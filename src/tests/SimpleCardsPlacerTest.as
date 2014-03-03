package tests
{
	import engines.Card;
	import engines.CardsGenerator;
	import engines.cardsPlacers.SimpleCardsPlacer;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import flexunit.framework.Assert;
	
	public class SimpleCardsPlacerTest
	{		
		private var _simpleCardsPlacer:SimpleCardsPlacer;
		private static var _mockCards:Vector.<Card>;
				
		[Before]
		public function setUp():void
		{
			_simpleCardsPlacer = new SimpleCardsPlacer();
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{			
			var mockFrontImages:Vector.<BitmapData> = new Vector.<BitmapData>();
			
			for (var i:uint = 0; i < 5; i++)
			{
				mockFrontImages.push(new BitmapData(100, 100, true, 0x000000));
			}
			
			var mockBackImage:BitmapData = new BitmapData(100, 100, true, 0xff0000);
			
			var generator:CardsGenerator = new CardsGenerator(mockFrontImages, mockBackImage);
			_mockCards = generator.generateRandomCards(20);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testPlaceCards():void
		{
			var targetContainer:Sprite = new Sprite();
			targetContainer.width = 500;
			targetContainer.height = 500;
			
			_simpleCardsPlacer.placeCards(targetContainer, _mockCards);
			Assert.assertEquals(_mockCards.length, targetContainer.numChildren);
		}
	}
}