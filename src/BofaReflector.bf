namespace Bofa;
using System;
using System.Collections;

public interface IBofaParseable
{
	public void ToBofaParseable(BofaParseable pValue);
	public void FromBofaParseable(Bofa pValue);
}

class BofaParseable
{
	private String _bofaString = new .() ~ delete(_);
	private uint32 depth = 1; 

	public StringView GetBofaString()
	{
		return this._bofaString;
	}

	public void AddNumber(StringView pName, float pValue)
	{
		if(_bofaString != "")
			_bofaString.Append('\n');
		_bofaString.Append(' ', depth);
		_bofaString.Append(scope $"n {pName} {pValue.ToString(.. scope .())}");
	}

	public void AddBoolean(StringView pName, bool pValue)
	{
		if(_bofaString != "")
			_bofaString.Append('\n');
		_bofaString.Append(' ', depth);
		_bofaString.Append(scope $"b {pName} {pValue.ToString(.. scope .())}");
	}

	public void AddLine(StringView pName, StringView pValue)
	{
		if(_bofaString != "")
			_bofaString.Append('\n');
		_bofaString.Append(' ', depth);
		var enumerator = pValue.Split('\n');
		_bofaString.Append(scope $"l {pName} {enumerator.GetNext()}");
	}

	public void AddBigNumber(StringView pName, double pValue)
	{
		if(_bofaString != "")
			_bofaString.Append('\n');
		_bofaString.Append(' ', depth);
		_bofaString.Append(scope $"bn {pName} {pValue.ToString(.. scope .())}");
	}

	public void AddInteger(StringView pName, int32 pValue)
	{
		if(_bofaString != "")
			_bofaString.Append('\n');
		_bofaString.Append(' ', depth);
		_bofaString.Append(scope $"i {pName} {pValue.ToString(.. scope .())}");
	}

	public void AddBigInteger(StringView pName, int64 pValue)
	{
		if(_bofaString != "")
			_bofaString.Append('\n');
		_bofaString.Append(' ', depth);
		_bofaString.Append(scope $"bi {pName} {pValue.ToString(.. scope .())}");
	}

	public void AddText(StringView pName, StringView pValue)
	{
		if(_bofaString != "")
			_bofaString.Append('\n');
		_bofaString.Append(' ', depth);
		var enumerator = pValue.Split('\n');
		_bofaString.Append(scope $"t {pName} {enumerator.GetNext().Value}");
		for(var line in enumerator)
		{
			_bofaString.Append('\n');
			_bofaString.Append(' ',depth+1);
			_bofaString.Append('-');
			_bofaString.Append(' ');
			_bofaString.Append(line);

		}
	}

	public void AddCustom(StringView pName, StringView pTypeName, StringView pValue)
	{
		if(_bofaString != "")
			_bofaString.Append('\n');
		_bofaString.Append(' ', depth);
		_bofaString.Append(scope $"c {pTypeName} {pName} {pValue}");
	}

	public void StartAddArray(StringView pName)
	{
		if(_bofaString != "")
			_bofaString.Append('\n');
		_bofaString.Append(' ', depth);
		_bofaString.Append(scope $"a {pName}\n");
		depth++;
	}
	public void StopAddArray()
	{
		depth--;
	}

	public void AddObject<T>(T pValue) where T : IBofaParseable
	{
		depth++;
		pValue.ToBofaParseable(this);
		depth--;
	}
}

