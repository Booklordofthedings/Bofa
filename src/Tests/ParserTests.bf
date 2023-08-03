namespace Bofa.Tests;
using System;

class ParserTests
{
	[Test]
	public static void TestParsing()
	{
		String toParse = scope .("""
			# comment
			number n 34324.4
			object o
				object_member n 432.5
				object_in_object o
					2_deep_member n 234324.7

			# empty lines also work

			text t
			-> adds to the last textline
			->
			# adding an empty line also works

			array a
				- n 34324.5
			# Arrays are handled the same as objects, they just dont care about what each entry is named
			""");

		
	}
}