bool isGUI(mat4 projMat) {
    return projMat[2][3] == 0.0 && projMat[3][3] == 1.0;
}

bool isHand(float fogStart, float fogEnd) {
    return fogStart == 0.0 && fogEnd == 1.0;
}

bool notPickup(mat4 modelViewMat) {
    return modelViewMat[3][1] > -80.0;
}

void discardControlGLPos(vec2 fragCoord, vec4 glpos) {
    // Placeholder function - implement your logic here
}

vec4 getOutColorSTDALock(vec4 color, vec4 vertexColor, vec2 texCoord, vec2 fragCoord) {
    // Placeholder function - implement your logic here
    return color * vertexColor;
}

vec4 getOutColorPickupRGBLock(vec4 color, vec4 vertexColor, vec2 texCoord) {
    // Placeholder function - implement your logic here
    return color * vertexColor;
}