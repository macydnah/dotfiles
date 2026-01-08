// ~/.config/hypr/blue-light-filter.frag

//
// https://github.com/hyprwm/Hyprland/blob/main/example/screenShader.frag
// https://github.com/hyprwm/Hyprland/raw/refs/heads/main/example/screenShader.frag
//
// Example blue light filter shader.
//

#version 300 es

precision mediump float;
in vec2 v_texcoord;
layout(location = 0) out vec4 fragColor;
uniform sampler2D tex;

void main() {

    vec4 pixColor = texture(tex, v_texcoord);

    pixColor[2] *= 0.500;

    fragColor = pixColor;
}
