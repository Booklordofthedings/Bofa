namespace Bofa;
using System;
using System.Collections;
//Books object format -> a
struct bofa
{
	private String stored = null; //Private stored value, only used if its the base parsed object

	public StringView name;
	public bofa_type type;
	public StringView type_name;
	public bofa_value value;


	///Cleans up all allocated memory
	public void Cleanup()
	{
		if(stored != null)
			delete stored;

		if(type == .multi_line)
			delete value.multi_line;
		else if(type == .array)
			for(var e in value.array)
				e.Cleanup();
		else if(type == .object)
			for(var e in value.object)
				e.value.Cleanup();
	}
}
[Union]
struct bofa_value
{
	public float number;
	public double big_number;
	public int32 integer;
	public int64 big_integer;
	public StringView text;
	public String multi_line;
	public StringView custom;
	public bofa[] array;
	public Dictionary<StringView, bofa*> object; //Pointer in order to protect us from data cycles
}
enum bofa_type
{
	number,
	big_number,
	integer,
	big_integer,
	text,
	multi_line,
	custom,
	array,
	object
}

/*

name c value

name o
    name n value //Object member
name a
- n value //Array member

name c typename value

name t
-> Part of the text entry
name o
    name a
    - n value



several different types
custom types
multi line types
arrays 
*/