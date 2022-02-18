codeunit 50200 "PPI NotificationActionHandler"
{
    procedure OpenShipToAddresses(ShipToAddrNotification: Notification)
    var
        ShipToAddress: Record "Ship-to Address";
        SalesHeader: Record "Sales Header";
        ShipToAddressListPage: Page "Ship-to Address List";
        CustNo: Code[20];
        OrderNo: Code[20];
        ShipToCode: Code[10];
    begin
        CustNo := ShipToAddrNotification.GetData('CustomerNo');
        OrderNo := ShipToAddrNotification.GetData('OrderNo');
        ShipToAddress.SetRange("Customer No.", CustNo);
        ShipToAddressListPage.LookupMode := true;
        ShipToAddressListPage.SetTableView(ShipToAddress);
        if ShipToAddressListPage.RunModal = Action::LookupOK then begin
            ShipToAddressListPage.GetRecord(ShipToAddress);
            SalesHeader.Get(SalesHeader."Document Type"::Order, OrderNo);
            SalesHeader.Validate("Ship-to Code", ShipToAddress.Code);
            SalesHeader.Modify();
        end;
    end;
}
