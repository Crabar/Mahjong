package engines.cardsPlacers
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import engines.Card;
	
	/**
	 * Basic cards' placer. Used for placing cards on playground.
	 * @author Crabar
	 */
	public class SimpleCardsPlacer implements ICardsPlacer
	{
		public function SimpleCardsPlacer():void
		{
		}
		
		private const horizontalGap:int = 3;
		private const paddingBottom:int = 5;
		private const paddingLeft:int = 5;
		private const paddingRight:int = 5;
		private const paddingTop:int = 5;
		private const verticalGap:int = 3;
		
		public function placeCards(target:Sprite, cards:Vector.<Card>):void
		{
			var sideCount:uint = uint(Math.sqrt(cards.length));
			const cardWidth:Number = cards[0].width;
			const cardHeight:Number = cards[0].height;
			var cardIndex:uint = 0;
			var rowIndex:uint = 0;
			var cardX:Number;
			var cardY:Number;
			var curCard:Card;
			
			while (cardIndex < cards.length)
			{
				for (var i:uint = 0; i < sideCount; i++)
				{
					cardX = paddingLeft + i * cardWidth + i * horizontalGap;
					cardY = paddingTop + rowIndex * cardHeight + rowIndex * verticalGap;
					
					curCard = cards[cardIndex];
					curCard.x = cardX;
					curCard.y = cardY;
					
					target.addChild(curCard);
					
					cardIndex++;
					
					if (cardIndex >= cards.length)
						break;
				}
				
				rowIndex++;
			}		
		}
		
		private function calcOptimalCardSize(playArea:Rectangle, cardsCount:uint):Number
		{
			return 0;
		}
	}
}
