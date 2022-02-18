tableextension 50210 "PPI Sales Header" extends "Sales Header"
{
    // The Notify variable is called two times: in the first instruction we set the message to show to the user by using the method Message, 
    // and in the second we just call the method Send that activates the notification on the page.
    fields
    {
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                ShipToAddress: Record "Ship-to Address";
                Notify: Notification;
                NotificationLbl: Label 'Customer %1 has more than one shipping address';
                OpenNotificationLbl: Label 'Choose one';
                NotificationMsg: Text;
            begin
                ShipToAddress.SetRange("Customer No.", Rec."Sell-to Customer No.");
                if ShipToAddress.Count > 1 then begin
                    NotificationMsg := StrSubstNo(NotificationLbl, Rec."Sell-to Customer Name");
                    Notify.Message(NotificationMsg);
                    Notify.SetData('CustomerNo', Rec."Sell-to Customer No.");
                    Notify.SetData('OrderNo', Rec."No.");
                    Notify.AddAction(OpenNotificationLbl,Codeunit::"PPI NotificationActionHandler",'OpenShipToAddresses');
                    Notify.Send();
                end;
            end;
        }
    }
}
