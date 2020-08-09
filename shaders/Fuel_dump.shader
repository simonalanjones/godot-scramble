shader_type canvas_item;

uniform vec4 tank : hint_color;
uniform vec4 ul_chars : hint_color;
uniform vec4 stand : hint_color;

void fragment()
{
	vec4 curr_color = texture(TEXTURE,UV); // Get current color of pixel
	if (curr_color == vec4(1,1,1,1)) // white 
	{
        COLOR = stand;
    }
	else if (curr_color == vec4(1,0,0,1))  // red
	{
        COLOR = vec4(ul_chars);
	}	
	else if (curr_color == vec4(0,1,0,1))  // green
	{
        COLOR = vec4(tank);
	}

	else 
	{
		COLOR = vec4(0,0,0,0); // black
	}
}