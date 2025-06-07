// Import Three.js library
import * as THREE from 'https://cdn.jsdelivr.net/npm/three@0.132.2/build/three.module.js';
import { GLTFLoader } from 'https://cdn.jsdelivr.net/npm/three@0.132.2/examples/jsm/loaders/GLTFLoader.js';
import { OrbitControls } from 'https://cdn.jsdelivr.net/npm/three@0.132.2/examples/jsm/controls/OrbitControls.js';

// Global variables
let scene, camera, renderer, door, key, doorOpen = false, keyAttempt = false;
let mixer, doorAction, keyAction, doorFailAction, keyFailAction;
let animationContainer;

// Initialize the 3D scene
function init() {
    // Create animation container
    animationContainer = document.getElementById('door-animation');
    
    // Create scene
    scene = new THREE.Scene();
    scene.background = new THREE.Color(0x000000);
    
    // Add ambient light
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
    scene.add(ambientLight);
    
    // Add directional light
    const dirLight = new THREE.DirectionalLight(0xffffff, 1);
    dirLight.position.set(5, 10, 7.5);
    dirLight.castShadow = true;
    scene.add(dirLight);
    
    // Add point light for golden glow
    const pointLight = new THREE.PointLight(0xffd700, 1, 100);
    pointLight.position.set(0, 5, 5);
    scene.add(pointLight);
    
    // Camera setup
    camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 0.1, 1000);
    camera.position.set(0, 5, 10);
    
    // Renderer setup
    renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.setPixelRatio(window.devicePixelRatio);
    renderer.shadowMap.enabled = true;
    animationContainer.appendChild(renderer.domElement);
    
    // Load models
    loadModels();
    
    // Add event listener for window resize
    window.addEventListener('resize', onWindowResize);
    
    // Start the animation loop
    animate();
}

// Load 3D models
function loadModels() {
    const loader = new GLTFLoader();
    
    // Load door model
    loader.load('../../assets/models/golden-door.glb', (gltf) => {
        door = gltf.scene;
        door.scale.set(2, 2, 2);
        door.position.set(0, 0, 0);
        door.castShadow = true;
        door.receiveShadow = true;
        scene.add(door);
        
        // Setup door animations
        mixer = new THREE.AnimationMixer(door);
        const clips = gltf.animations;
        if (clips && clips.length) {
            doorAction = mixer.clipAction(clips.find(clip => clip.name === 'DoorOpen'));
            doorFailAction = mixer.clipAction(clips.find(clip => clip.name === 'DoorFail'));
        }
    });
    
    // Load key model
    loader.load('../../assets/models/golden-key.glb', (gltf) => {
        key = gltf.scene;
        key.scale.set(1, 1, 1);
        key.position.set(0, 3, 5);
        key.castShadow = true;
        scene.add(key);
        
        // Setup key animations
        const keyMixer = new THREE.AnimationMixer(key);
        const keyClips = gltf.animations;
        if (keyClips && keyClips.length) {
            keyAction = keyMixer.clipAction(keyClips.find(clip => clip.name === 'KeyInsert'));
            keyFailAction = keyMixer.clipAction(keyClips.find(clip => clip.name === 'KeyFail'));
        }
    });
}

// Window resize handler
function onWindowResize() {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
}

// Animation loop
function animate() {
    requestAnimationFrame(animate);
    
    if (mixer) {
        mixer.update(0.016); // Update animations (approx 60fps)
    }
    
    renderer.render(scene, camera);
}

// Function to play door open animation
function openDoor() {
    if (!doorAction || doorOpen) return;
    
    doorAction.reset();
    doorAction.setLoop(THREE.LoopOnce);
    doorAction.clampWhenFinished = true;
    doorAction.play();
    doorOpen = true;
    
    // Play key insert animation
    if (keyAction) {
        keyAction.reset();
        keyAction.setLoop(THREE.LoopOnce);
        keyAction.clampWhenFinished = true;
        keyAction.play();
    }
    
    // After animation completes, redirect
    setTimeout(() => {
        // Create a white plane that grows to cover the screen
        const coverGeometry = new THREE.PlaneGeometry(window.innerWidth * 0.01, window.innerHeight * 0.01);
        const coverMaterial = new THREE.MeshBasicMaterial({ color: 0xffffff });
        const coverPlane = new THREE.Mesh(coverGeometry, coverMaterial);
        coverPlane.position.set(0, 0, 5);
        scene.add(coverPlane);
        
        // Animate the plane to cover the screen
        const expandCover = () => {
            coverPlane.scale.x *= 1.2;
            coverPlane.scale.y *= 1.2;
            
            if (coverPlane.scale.x < 100) {
                requestAnimationFrame(expandCover);
            } else {
                // Redirect to dashboard
                window.location.href = '../../views/dashboard/index.html';
            }
        };
        
        expandCover();
    }, 2000);
}

// Function to play door fail animation
function failDoor() {
    if (!doorFailAction || doorOpen) return;
    
    doorFailAction.reset();
    doorFailAction.setLoop(THREE.LoopOnce);
    doorFailAction.play();
    
    // Play key fail animation
    if (keyFailAction) {
        keyFailAction.reset();
        keyFailAction.setLoop(THREE.LoopOnce);
        keyFailAction.play();
    }
    
    // Shake the camera to emphasize failure
    const initialPosition = { x: camera.position.x, y: camera.position.y, z: camera.position.z };
    const shakeCamera = () => {
        camera.position.x = initialPosition.x + (Math.random() - 0.5) * 0.2;
        camera.position.y = initialPosition.y + (Math.random() - 0.5) * 0.2;
        
        setTimeout(() => {
            if (keyAttempt) {
                shakeCamera();
            } else {
                // Reset camera
                camera.position.set(initialPosition.x, initialPosition.y, initialPosition.z);
            }
        }, 50);
    };
    
    keyAttempt = true;
    shakeCamera();
    
    // Stop camera shake after 500ms
    setTimeout(() => {
        keyAttempt = false;
    }, 500);
}

// Show the 3D animation
function showDoorAnimation() {
    animationContainer.style.display = 'block';
    animationContainer.style.opacity = '1';
}

// Hide the 3D animation
function hideDoorAnimation() {
    animationContainer.style.opacity = '0';
    setTimeout(() => {
        animationContainer.style.display = 'none';
    }, 500);
}

// Export functions
export { init, openDoor, failDoor, showDoorAnimation, hideDoorAnimation };