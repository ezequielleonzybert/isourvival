shader_type canvas_item;

void fragment() {
    vec2 sides = smoothstep(0.0, 0.05, UV) * smoothstep(1.0, 0.95, UV);
    
    // Multiplica ambos ejes para obtener un centro transparente cuadrado y homogéneo
    float center_mask = sides.x * sides.y;
    
    // Invierte el resultado para que el centro sea transparente y los bordes negros
    float alpha = 0.9 - center_mask;
    
    COLOR = vec4(0.0, 0.0, 0.0, alpha);
}