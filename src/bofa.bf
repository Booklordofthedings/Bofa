namespace Bofa;
using System;
class Bofa
{
	public eBofaType Type;
	public StringView TypeName;
	public StringView Name;
	public BofaValue Value;

	private String Data = null;
	private Bofa LastObject;
	private Bofa LastText;

	public ~this()
	{
		if(Data != null)
			delete Data;
		if(Type == .)
	}
}