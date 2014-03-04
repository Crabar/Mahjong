package engines
{
	import flash.display.BitmapData;
	import flash.errors.IOError;
	
	/**
	 * Used for generating cards in random positions.
	 * @author Crabar
	 */
	public class CardsGenerator
	{
		/**
		 * 
		 * @param frontImages Array of different front images for cards.
		 * @param backImage Card's back image.
		 */
		public function CardsGenerator(frontImages:Vector.<BitmapData>, backImage:BitmapData)
		{
			_frontImages = frontImages;
			_backImage = backImage;
		}
		
		private var _backImage:BitmapData;
		
		private var _frontImages:Vector.<BitmapData>;
		
		public function generateRandomCards(count:uint):Vector.<Card>
		{
			if (count % 2 != 0)
				throw new IOError("Cards count must be even!");
			
			var cards:Vector.<Card> = new Vector.<Card>(count);
			var preparedCards:Array = []; // of {Card, weight}
			var imageIndex:uint = 0;
			var firstCard:Card;
			var secondCard:Card;
			
			for (var i:uint = 0; i < count / 2; i++)
			{
				firstCard = new Card(_frontImages[imageIndex], _backImage);
				secondCard = new Card(_frontImages[imageIndex], _backImage);
				
				preparedCards.push({"card": firstCard, "weight": Math.random()});
				preparedCards.push({"card": secondCard, "weight": Math.random()});
				
				if (imageIndex + 1 == _frontImages.length)
					imageIndex = 0;
				else
					imageIndex++;
			}
			
			preparedCards.sortOn("weight", Array.NUMERIC);
			
			for (var j:uint = 0; j < preparedCards.length; j++)
			{
				cards[j] = preparedCards[j].card;
			}
			
			return cards;
		}
	}
}
