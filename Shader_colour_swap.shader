shader_type canvas_item;

uniform vec4 outline : hint_color;
uniform vec4 fill : hint_color;
uniform vec4 outline_brick : hint_color;
uniform vec4 fill_brick : hint_color;

// this is for the vertical brick section
uniform vec4 fill_brick_block : hint_color;
uniform vec4 outline_brick_block : hint_color;




void fragment()
{
	vec4 curr_color = texture(TEXTURE,UV); // Get current color of pixel
	if (curr_color == vec4(1,1,1,1)) // white
	{
        COLOR = outline;
    }
	else if (curr_color == vec4(0,1,0,1))  // green
	{
        COLOR = vec4(fill);
	}
	else if (curr_color == vec4(1,0,0,1)) // red
	{
		COLOR = vec4(fill_brick);
	}
	else if (curr_color == vec4(1,1,0,1)) // yellow
	{
		COLOR = vec4(outline_brick);
	}
	else if (curr_color == fill_brick_block)
	{
		COLOR = vec4(1,0,0,1)
	}
	else if (curr_color == outline_brick_block)
	{
		COLOR = vec4(1,1,0,1)
	}
	
	else 
	{
		COLOR = vec4(0,0,0,0); // black
	}
	
}