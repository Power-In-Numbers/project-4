shader_type spatial;

uniform sampler2D sticker_texture : source_color;

void fragment() {
    vec4 sticker = texture(sticker_texture, UV);

    ALBEDO = sticker.rgb;
    ALPHA = sticker.a;
}