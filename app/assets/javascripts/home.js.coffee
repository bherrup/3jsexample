# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

() ->
    lastTime = 0;
    vendors = ['webkit', 'moz'];
    for x in vendors.length 
        if !window.requestAnimationFrame
            window.requestAnimationFrame = window[vendors[x]+'RequestAnimationFrame']
            window.cancelAnimationFrame =  window[vendors[x]+'CancelAnimationFrame'] || window[vendors[x]+'CancelRequestAnimationFrame']

    if (!window.requestAnimationFrame)
        window.requestAnimationFrame = (callback, element) ->
            currTime = new Date().getTime();
            timeToCall = Math.max(0, 16 - (currTime - lastTime));
            id = window.setTimeout( () ->
                 callback(currTime + timeToCall)
                 timeToCall)
            lastTime = currTime + timeToCall;
            return id;


    if (!window.cancelAnimationFrame)
        window.cancelAnimationFrame = (id) ->
            clearTimeout(id);
            nil
    nil


$ ->
    width = 300
    height = 300
    
    view_angle = 45
    aspect = width/height
    near = 0.1
    far = 10000
    
    $container = $("#canvasboard")
    renderer = new THREE.WebGLRenderer
    camera = new THREE.PerspectiveCamera view_angle, aspect, near, far
    
    
    scene = new THREE.Scene
    
    scene.add camera
    camera.position.z = 400
    
    renderer.setSize width, height
    $container.append renderer.domElement
    
    sphere_rad = 100
    sphere_segs = 20
    sphere_rings = 20
    
    sphere_material = new THREE.MeshLambertMaterial {color: 0xCC0000}
    
    sphere = new THREE.Mesh(new THREE.SphereGeometry(sphere_rad, sphere_segs, sphere_rings), sphere_material)
    scene.add(sphere)
    
    point_light = new THREE.PointLight(0xffffff)

    point_light.position.x = 10;
    point_light.position.y = 100;
    point_light.position.z = 130;

    scene.add point_light
    
    renderer.render(scene, camera)
    
    update = () ->
        point_light.position.x++
        point_light.position.z++
        if point_light.position.x > 400
            point_light.position.x = -400
        if point_light.position.z > 400
            point_light.position.z = -0
        renderer.render(scene, camera)
        window.requestAnimationFrame(update)
    
    update()