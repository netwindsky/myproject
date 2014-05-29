import flash.events.*;
import mx.events.*;
import mx.collections.ArrayCollection;
import flash.net.*;

private function bCalculator_clickEvent(event:MouseEvent):void {
    var r:Function = function(res:Object):void {
	tAnswer.text = String(res);
    }
    if (nc != null)
	nc.call('CalculatorService.add', new Responder(r, null), parseInt(tN1.text), parseInt(tN2.text));
}

[Bindable]
private var dgQuery_data:ArrayCollection = new ArrayCollection();

private function bQuery_clickEvent(event:MouseEvent):void {
    var r:Function = function(res:Object):void {
	for each(var p:Object in res) {
	    dgQuery_data.addItem(p);
	}
    }

    var query:Object = {limit: 5, nameLen: 3, minAge: 30, maxAge: 40};
    nc.call('QueryService.getPeopleList', new Responder(r, null), query);
}

private var nc:NetConnection = null;

private function init():void {
    addEventListener(Event.CLOSING, application_closingEvent);
    try {
	nc = new NetConnection();
	nc.connect('http://localhost/~daoki/amf.abx');
    } catch (err:Error) {
	trace(err.message);
    }
}

private function application_closingEvent(event:Event):void {
    nc.close();
}
