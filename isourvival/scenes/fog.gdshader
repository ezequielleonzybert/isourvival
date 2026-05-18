shader_type canvas_item;

void fragment() {
    // Calcula cuánto se acerca el píxel a los bordes (0 en el borde, 1 en el centro)
    vec2 sides = smoothstep(0.0, 0.15, UV) * smoothstep(1.0, 0.85, UV);
    
    // Multiplica ambos ejes para obtener un centro transparente cuadrado y homogéneo
    float center_mask = sides.x * sides.y;
    
    // Invierte el resultado para que el centro sea transparente y los bordes negros
    float alpha = 0.4 - center_mask;
    
    COLOR = vec4(0.0, 0.0, 0.0, alpha);
}