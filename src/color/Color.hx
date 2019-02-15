package color;

/**
 * ...
 * @author P.J.Shand
 */
abstract Color(UInt) from Int from UInt to UInt
{
	public var red(get, set):UInt;
	public var green(get, set):UInt;
	public var blue(get, set):UInt;
	public var alpha(get, set):UInt;
	
	public function new(value:UInt) {
		this = value;
	}
	
	inline function get_red():UInt 
	{
		return (this & 0x00ff0000) >>> 16;
	}
	
	inline function get_green():UInt 
	{
		return (this & 0x0000ff00) >>> 8;
	}
	
	inline function get_blue():UInt 
	{
		return this & 0x000000ff;
	}
	
	inline function get_alpha():UInt 
	{
		return this >>> 24;
	}
	
	inline function set_red(value:UInt):UInt 
	{
		this = (alpha << 24) | (value << 16) | (green << 8) | blue;
		return value;
	}
	
	inline function set_green(value:UInt):UInt 
	{
		this = (alpha << 24) | (red << 16) | (value << 8) | blue;
		return value;
	}
	
	inline function set_blue(value:UInt):UInt 
	{
		this = (alpha << 24) | (red << 16) | (green << 8) | value;
		return value;
	}
	
	inline function set_alpha(value:UInt):UInt 
	{
		this = (value << 24) | (red << 16) | (green << 8) | blue;
		return value;
	}
	
	static public function random(alpha:Null<Int>=null, red:Null<Int>=null, green:Null<Int>=null, blue:Null<Int>=null):Color
	{
		var randomColor:Color = 0x0;
		if (alpha == null) randomColor.alpha = Math.round(0xFF * Math.random());
		else randomColor.alpha = alpha;
		
		if (red == null) randomColor.red = Math.round(0xFF * Math.random());
		else randomColor.red = red;
		
		if (green == null) randomColor.green = Math.round(0xFF * Math.random());
		else randomColor.green = green;
		
		if (blue == null) randomColor.blue = Math.round(0xFF * Math.random());
		else randomColor.blue = blue;
		
		return randomColor;
	}

	@:from
	static public function fromString(s:String) {
		if (s.indexOf("#") == 0)		return new Color(Std.parseInt("0x" + s.substring(1, s.length)));
		else if (s.indexOf("0x") == 0)	return new Color(Std.parseInt(s));
		// unable to parse
		return new Color(0);
	}

	public function mix(color:Color, strength:Float):Color
	{
		var output:Color = new Color(0);
		output.red = Math.floor((red * (1 - strength)) + (color.red * strength));
		output.green = Math.floor((green * (1 - strength)) + (color.green * strength));
		output.blue = Math.floor((blue * (1 - strength)) + (color.blue * strength));
		output.alpha = Math.floor((alpha * (1 - strength)) + (color.alpha * strength));
		return output;
	}

	function toString()
	{
		return "0x" + StringTools.hex(this, 8);
	}
}