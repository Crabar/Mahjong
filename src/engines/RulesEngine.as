package engines
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import engines.events.CardEvent;
	
	public class RulesEngine
	{
		public function RulesEngine(playGround:Sprite, cards:Vector.<Card>)
		{
			_playGround = playGround;
			_pairsCount = cards.length / 2;
			
			for (var i:uint = 0; i < cards.length; i++)
			{
				cards[i].addEventListener(CardEvent.CARD_OPEN, onCardOpen);
				cards[i].addEventListener(CardEvent.CARD_CLOSE, onCardClose);
			}
		
		}
		
		private var _openedCards:Vector.<Card> = new Vector.<Card>();
		
		private var _pairsCount:uint;
		
		private var _playGround:Sprite;
		
		private function blockPlayground():void
		{
			_playGround.mouseChildren = false;
		}
		
		private function checkWin():void
		{
			if (_pairsCount == 0)
				showWinMessage();
		}
		
		private function showWinMessage():void
		{
			var winText:TextField = new TextField();
			winText.text = "Congratulations! You won!";
			var winTextFormat:TextFormat = new TextFormat(null, 32, 0x11aa11, true, true, false, "", "", TextFormatAlign.CENTER);
			winText.setTextFormat(winTextFormat);
			winText.selectable = false;
			winText.width = _playGround.stage.stageWidth;
			winText.height = 40;
			winText.y = _playGround.stage.stageHeight / 2;
			_playGround.addChild(winText);
		}
		
		private function destroyCard(card:Card):void
		{
			card.destroy();
		}
		
		private function isCardsEqual(firstCard:Card, secondCard:Card):Boolean
		{
			return firstCard.front == secondCard.front;
		}
		
		private function onCardClose(event:CardEvent):void
		{
			var cardIndex:uint = _openedCards.indexOf(event.target);
			_openedCards.splice(cardIndex, 1);
			
			if (_openedCards.length == 0)
				unblockPlayground();
		}
		
		private function onCardOpen(event:CardEvent):void
		{
			_openedCards.push(event.target);
			
			if (_openedCards.length == 2)
			{
				if (isCardsEqual(_openedCards[0], _openedCards[1]))
				{
					removeCurrentPair();
					checkWin();
				}
				else
					blockPlayground();
			}
		}
		
		private function removeCurrentPair():void
		{
			_openedCards[0].removeEventListener(CardEvent.CARD_CLOSE, onCardClose);
			_openedCards[1].removeEventListener(CardEvent.CARD_CLOSE, onCardClose);
			//
			destroyCard(_openedCards[0]);
			destroyCard(_openedCards[1]);
			//
			_openedCards = new Vector.<Card>();
			_pairsCount--;
		}
		
		private function unblockPlayground():void
		{
			_playGround.mouseChildren = true;
		}
	}
}
