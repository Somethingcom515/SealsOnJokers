#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 frozen;
extern MY_HIGHP_OR_MEDIUMP number dissolve;
extern MY_HIGHP_OR_MEDIUMP number time;
extern MY_HIGHP_OR_MEDIUMP vec4 texture_details;
extern MY_HIGHP_OR_MEDIUMP vec2 image_details;
extern bool shadow;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_1;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_2;

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01;

    float t = time * 10.0 + 2003.;
    vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);

    vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
    vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
    vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;
    vec2 borders = vec2(0.2, 0.8);

    float res = (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = Texel(texture, texture_coords);
    vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;
    vec2 adjusted_uv = uv - vec2(0.5, 0.5);
    adjusted_uv.x = adjusted_uv.x*texture_details.b/texture_details.a;

    number dist = length(adjusted_uv);
    number slow_t = frozen.r * 0.1;

    number frost1 = 0.5 + 0.5 * sin(uv.x*21.7 + cos(uv.y*15.3 + slow_t*0.7)) * cos(uv.y*17.1 + sin(uv.x*27.9 - slow_t*0.5));
    number frost2 = 0.5 + 0.5 * sin(uv.x*43.3 - uv.y*37.7 + slow_t*0.4) * cos(uv.y*51.1 + uv.x*39.3 - slow_t*0.25);
    number frost3 = 0.5 + 0.5 * sin((uv.x + uv.y)*71.3 + slow_t*0.15) * cos((uv.x - uv.y)*63.7 - slow_t*0.1);
    number frost4 = 0.5 + 0.5 * sin(uv.x*97.1 + uv.y*89.3) * cos(uv.y*103.7 - uv.x*79.1);
    number frost_pattern = frost1*0.40 + frost2*0.30 + frost3*0.20 + frost4*0.10;

    number edge_mask = smoothstep(0.05, 0.45, dist);
    number frost = frost_pattern * (0.12 + 0.88 * edge_mask);

    frost *= 0.92 + 0.08 * sin(frozen.r * 0.35);
    frost = clamp(frost, 0.0, 1.0);

    number vein_raw = sin(uv.x*13.3 + cos(uv.y*19.7)*2.5 + slow_t*0.2) * cos(uv.y*16.1 + sin(uv.x*11.3)*3.1 - slow_t*0.15);
    number veins = (1.0 - smoothstep(0.0, 0.07, abs(vein_raw))) * 0.20;
    veins *= smoothstep(0.10, 0.35, dist);
    number vein2_raw = sin(uv.x*31.7 - uv.y*23.1 + slow_t*0.1) * cos(uv.y*29.3 + uv.x*37.9);
    number veins2 = (1.0 - smoothstep(0.0, 0.05, abs(vein2_raw))) * 0.10;
    veins2 *= smoothstep(0.20, 0.45, dist);
    number total_veins = veins + veins2;

    number sp_t = frozen.r * 1.2;
    number sp1 = pow(max(0., sin(uv.x*73.7 + sp_t*1.30) * sin(uv.y*67.3 - sp_t*0.90)), 18.);
    number sp2 = pow(max(0., cos(uv.x*89.1 - sp_t*0.80) * cos(uv.y*83.9 + sp_t*1.10)), 18.);
    number sp3 = pow(max(0., cos(uv.x*61.9 - uv.y*71.3 - sp_t*0.65)*sin(uv.y*59.1 + sp_t*0.45)), 20.);
    number sparkle = (sp1 + sp2 + sp3) * 1.8;

    vec2 shimmer_dir = vec2(cos(frozen.r*0.06), sin(frozen.r*0.09));
    number shimmer_angle = dot(shimmer_dir, adjusted_uv)
                         / (length(shimmer_dir) * max(length(adjusted_uv), 0.001));
    number shimmer = max(0., cos(shimmer_angle*3.14*1.8 + frozen.r*0.25) - 0.5) * 0.25;
    shimmer *= smoothstep(0.05, 0.25, dist);

    number lum = dot(tex.rgb, vec3(0.299, 0.587, 0.114));
    vec3 result = mix(tex.rgb, vec3(lum), 0.45);
    result *= vec3(0.72, 0.86, 1.14);
    vec3 frost_col = vec3(0.82, 0.93, 1.0);
    result = mix(result, frost_col, frost * 0.50);
    result += total_veins * vec3(0.60, 0.78, 1.0);
    result += shimmer * vec3(0.45, 0.65, 0.95);
    result += sparkle * vec3(0.75, 0.88, 1.0);
    result = min(result, vec3(1.0));
    tex.rgb = result;
    return dissolve_mask(tex, texture_coords, uv);
}

extern MY_HIGHP_OR_MEDIUMP vec2 mouse_screen_pos;
extern MY_HIGHP_OR_MEDIUMP float hovering;
extern MY_HIGHP_OR_MEDIUMP float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif