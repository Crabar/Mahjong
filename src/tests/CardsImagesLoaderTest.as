package tests
{
	import flash.events.Event;
	import flexunit.framework.Assert;
	import org.flexunit.async.Async;
	import utils.CardsImagesLoader;
	
	public class CardsImagesLoaderTest
	{
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		private var _testLoader:CardsImagesLoader;
		
		[Before]
		public function setUp():void
		{
			_testLoader = new CardsImagesLoader();
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test(async)]
		public function testLoadImages():void
		{
			var imagesCount:uint = 5;
			Assert.assertNull(_testLoader.images);
			//
			_testLoader.addEventListener(Event.COMPLETE, Async.asyncHandler(this, onComplete, 1000, imagesCount, onTimeout));
			_testLoader.loadImages("cards", imagesCount);
		}
		
		private function onComplete(event:Event, passThroughData:Object):void
		{
			Assert.assertNotNull(_testLoader.images);
			Assert.assertEquals(passThroughData, _testLoader.images.length);
			
			for (var i:uint = 0; i < _testLoader.images.length; i++)
			{
				Assert.assertNotNull(_testLoader.images[i]);
			}
		}
		
		private function onTimeout(passThroughData:Object):void
		{
			Assert.fail("Load images timeout!");
		}
	}
}
