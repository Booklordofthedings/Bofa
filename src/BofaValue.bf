namespace Bofa;
using System;
using System.Collections;
[Union]
struct BofaValue
{
	float Number;
	double BigNumber;
	int32 Integer;
	int64 BigInteger;
	bool Boolean;
	StringView Line;
	StringView Custom;
	String Text;
	List<Bofa> Array;
	List<Bofa> Object;
}