package
{
	import engines.Card;
	import engines.CardsGenerator;
	import engines.RulesEngine;
	import engines.cardsPlacers.ICardsPlacer;
	import engines.cardsPlacers.SimpleCardsPlacer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import utils.CardsImagesLoader;
	
	[SWF(width="1024", height="768", frameRate="24", backgroundColor="0xBABABA")]
	public class Mahjong extends Sprite
	{
		public function Mahjong()
		{
			initStageParameters();
			initPlayGround();
			addRestartButton();

			var loader:CardsImagesLoader = new CardsImagesLoader();
			loader.addEventListener(Event.COMPLETE, onCardsImagesLoad);
			loader.loadImages("cards", 5);
		}
		
		[Embed(source="/../assets/0.png")]
		private var _backImage:Class;
		
		private var _playGround:Sprite;
		private var _cardsImages:Vector.<BitmapData>;
		
		private function initStageParameters():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		private function initPlayGround():void
		{
			_playGround = new Sprite();
			_playGround.y = 25;
			addChild(_playGround);			
		}
		
		private function addRestartButton():void
		{
			var restartButton:TextField = new TextField();
			restartButton.text = "Restart";
			var textFormat:TextFormat = new TextFormat(null, 16, 0xffffff, true, false, false, "", "", TextFormatAlign.CENTER);
			restartButton.setTextFormat(textFormat);
			restartButton.background = true;
			restartButton.selectable = false;
			restartButton.mouseEnabled = false;
			restartButton.backgroundColor = 0x333333;
			restartButton.width = 200;
			restartButton.height = 20;
			var container:Sprite = new Sprite();
			container.buttonMode = true;
			container.x = 5;
			container.y = 5;
			container.addChild(restartButton);
			container.addEventListener(MouseEvent.CLICK, onRestartButtonClick);
			addChild(container);
		}
		
		private function onRestartButtonClick(event:MouseEvent):void
		{
			startNewGame();
		}
		
		private function startNewGame():void
		{
			if (!_cardsImages)
			{
				throw new Error("Cards images didn't load!");
				return;
			}
			
			_playGround.removeChildren();
			var cardsGenerator:CardsGenerator = new CardsGenerator(_cardsImages, new _backImage().bitmapData);
			var cards:Vector.<Card> = cardsGenerator.generateRandomCards(16);
			var cardsPlacer:ICardsPlacer = new SimpleCardsPlacer();
			cardsPlacer.placeCards(_playGround, cards);
			var rulerEngine:RulesEngine = new RulesEngine(_playGround, cards);
		}
		
		private function onCardsImagesLoad(event:Event):void
		{
			_cardsImages = CardsImagesLoader(event.target).images;	
			startNewGame();
		}
	}
}
