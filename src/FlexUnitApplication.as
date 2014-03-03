package
{
	import Array;
	
	import flash.display.Sprite;
	
	import flexunit.flexui.FlexUnitTestRunnerUIAS;
	
	import tests.CardTest;
	import tests.CardsGeneratorTest;
	import tests.CardsImagesLoaderTest;
	import tests.SimpleCardsPlacerTest;
	
	public class FlexUnitApplication extends Sprite
	{
		public function FlexUnitApplication()
		{
			onCreationComplete();
		}
		
		private function onCreationComplete():void
		{
			var testRunner:FlexUnitTestRunnerUIAS=new FlexUnitTestRunnerUIAS();
			testRunner.portNumber=8765; 
			this.addChild(testRunner); 
			testRunner.runWithFlexUnit4Runner(currentRunTestSuite(), "Mahjong");
		}
		
		public function currentRunTestSuite():Array
		{
			var testsToRun:Array = new Array();
			testsToRun.push(tests.CardTest);
			testsToRun.push(tests.CardsGeneratorTest);
			testsToRun.push(tests.CardsImagesLoaderTest);
			testsToRun.push(tests.SimpleCardsPlacerTest);
			return testsToRun;
		}
	}
}