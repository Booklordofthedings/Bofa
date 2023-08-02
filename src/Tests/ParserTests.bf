namespace Bofa.Tests;
using System;

class ParserTests
{
	[Test]
	public static void TestParsing()
	{
		String toParse = scope .("""
			number n 13213.2
			""");

		var res = ParseBofa(toParse);
		Console.WriteLine(res.Value);
		Console.Read();
	}
}