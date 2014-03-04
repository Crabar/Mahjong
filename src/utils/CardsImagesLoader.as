package utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	[Event(name="complete", type="flash.events.Event")]
	public class CardsImagesLoader extends EventDispatcher
	{
		/**
		 * Used for loading cards' images.
		 */
		public function CardsImagesLoader()
		{
		}
		
		private var _imageLoadCounter:uint;
		
		private var _images:Vector.<BitmapData>;
		
		public function get images():Vector.<BitmapData>
		{
			return _images;
		}
		
		
		/**
		 * Loads images for cards by next pattern <code>folder/~image number~.png</code>. Load starts from 1 and end on <code>lastIndex</code>.
		 * @param folder Path that containts images.
		 * @param lastIndex Last image's number.
		 */
		public function loadImages(folder:String, lastIndex:uint):void
		{
			clearData();
			_imageLoadCounter = lastIndex;
			var loader:Loader;
			
			for (var i:uint = 1; i <= lastIndex; i++)
			{
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoadComplete);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				loader.load(new URLRequest(folder + "/" + i + ".png"));
			}
		}
		
		private function clearData():void
		{
			_images = new Vector.<BitmapData>();
		}
		
		private function onIOError(event:IOErrorEvent):void
		{
			_imageLoadCounter--;
			trace(event.text);
		}
		
		private function onImageLoadComplete(event:Event):void
		{
			_imageLoadCounter--;
			var bitmap:Bitmap = event.target.content;
			_images.push(bitmap.bitmapData);
			
			if (_imageLoadCounter == 0)
				dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}
