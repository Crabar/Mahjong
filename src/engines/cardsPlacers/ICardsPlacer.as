package engines.cardsPlacers
{
	import engines.Card;
	
	import flash.display.Sprite;

	public interface ICardsPlacer
	{
		function placeCards(target:Sprite, cards:Vector.<Card>):void
	}
}