package tests
{
	import engines.Card;
	import engines.CardsGenerator;
	
	import flash.display.BitmapData;
	
	import flexunit.framework.Assert;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.everyItem;
	import org.hamcrest.core.allOf;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;
	
	public class CardsGeneratorTest
	{
		private var _cardsGenerator:CardsGenerator;
		
		private static var _mockBackImage:BitmapData;
		
		private static var _mockFrontImages:Vector.<BitmapData>;
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
			_mockFrontImages = new Vector.<BitmapData>();
			
			for (var i:uint = 0; i < 5; i++)
			{
				_mockFrontImages.push(new BitmapData(100, 100, true, 0x000000));
			}
			
			_mockBackImage = new BitmapData(100, 100, true, 0xff0000);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Before]
		public function setUp():void
		{
			_cardsGenerator = new CardsGenerator(_mockFrontImages, _mockBackImage);
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test(expects="flash.errors.IOError")]
		public function testGenerateRandomCardsBasic():void
		{
			var cardsCount:uint = 21;
			_cardsGenerator.generateRandomCards(cardsCount);
			//
			var cards:Vector.<Card> = _cardsGenerator.generateRandomCards(cardsCount);
			Assert.assertNotNull(cards);
			Assert.assertEquals(cardsCount, cards.length);			
			assertThat(cards, everyItem(notNullValue()));
		}
		
		[Test]
		public function testGenerateRandomCardsLogic():void
		{
			var cardsCount:uint = 30;
			var cards:Vector.<Card> = _cardsGenerator.generateRandomCards(cardsCount);
			var equalCardsCount:uint;
			
			for each (var card:Card in cards)
			{
				equalCardsCount = 0;
				
				for (var i:uint = 0; i < cards.length; i++)
				{
					if (card.front == cards[i].front)
						equalCardsCount++;
				}
				
				Assert.assertEquals("The cards are not even!", 0, equalCardsCount % 2);
			}
		}
	}
}
