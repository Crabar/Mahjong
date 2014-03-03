package tests
{
	import engines.Card;
	import engines.events.CardEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.async.Async;
	
	public class CardTest
	{
		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testCard():void
		{
			var back:BitmapData = new BitmapData(1, 1);
			var card:Card = new Card(new BitmapData(1, 1), back);
			var cardImage:Bitmap = Bitmap(card.getChildAt(0));
			Assert.assertEquals("Card is not closed!", cardImage.bitmapData, back);
		}
		
		[Test(async)]
		public function testClose():void
		{
			var back:BitmapData = new BitmapData(1, 1);
			var card:Card = new Card(new BitmapData(1, 1), back);
			card.addEventListener(CardEvent.CARD_CLOSE, Async.asyncHandler(this, onCardClose, 100, back, onCardEventTimeout));
			card.open();
			card.close();
		}
		
		[Test]
		public function testDestroy():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test(async)]
		public function testOpen():void
		{
			var card:Card = new Card(new BitmapData(1, 1), new BitmapData(1, 1));
			card.addEventListener(CardEvent.CARD_OPEN, Async.asyncHandler(this, onCardOpen, 100, null, onCardEventTimeout));
			card.open();
		}
		
		private function onCardOpen(event:CardEvent, passThroughData:Object):void
		{
			var cardImage:Bitmap = Bitmap(Card(event.target).getChildAt(0));
			Assert.assertEquals("Card is not opened!", cardImage.bitmapData, Card(event.target).front);
		}
		
		private function onCardClose(event:CardEvent, passThroughData:Object):void
		{
			var cardImage:Bitmap = Bitmap(Card(event.target).getChildAt(0));
			Assert.assertEquals("Card is not closed!", cardImage.bitmapData, passThroughData);
		}
		
		private function onCardEventTimeout(passThroughData:Object):void
		{
			Assert.fail("Card event is not dispatched!");
		}
	}
}
