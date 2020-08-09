shader_type canvas_item;

uniform vec4 left : hint_color;
uniform vec4 right : hint_color;
uniform vec4 middle : hint_color;


void fragment()
{
	vec4 curr_color = texture(TEXTURE,UV); // Get current color of pixel
	if (curr_color == vec4(1,1,1,1)) // white 
	{
        COLOR = left;
    }
	else if (curr_color == vec4(1,0,0,1))  // red
	{
        COLOR = vec4(middle);
	}	
	else if (curr_color == vec4(0,1,0,1))  // green
	{
        COLOR = vec4(right);
	}
	else 
	{
		COLOR = vec4(0,0,0,0); // black
	}
}