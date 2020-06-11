shader_type canvas_item;

uniform vec4 outline : hint_color;
uniform vec4 fill : hint_color;
uniform vec4 thrust : hint_color;

void fragment()
{
	vec4 curr_color = texture(TEXTURE,UV); // Get current color of pixel
	if (curr_color == vec4(1,1,1,1)) // white 
	{
        COLOR = outline;
    }
	else if (curr_color == vec4(1,0,0,1))  // red
	{
        COLOR = vec4(thrust);
	}	
	else if (curr_color == vec4(0,1,0,1))  // green
	{
        COLOR = vec4(fill);
	}
	else 
	{
		COLOR = vec4(0,0,0,0); // black
	}
}