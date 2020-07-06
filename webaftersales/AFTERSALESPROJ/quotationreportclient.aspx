<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="quotationreportclient.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotationreportclient" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="../Scripts/bootstrap.js"></script>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <link href="css/gridcss.css" rel="stylesheet" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="well">
            <h3><strong>Quotation Report Viewer</strong></h3>
            <div class="navbar-right">
                <asp:LinkButton ID="LinkButton4" CssClass="btn btn-default" runat="server">back</asp:LinkButton>
            </div>
        </div>
        <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>"
            SelectCommand="select 
  a.ASENO,a.ITEM,a.KNO,a.WDWLOC,b.UNITPRICE,b.QTY,b.NETAMOUNT,b.MARKUP,b.ARTICLENO,b.DESCRIPTION from ITEMTB as a
  inner join partstb as b on a.id = b.iid WHERE (a.[ASENO] = @ASENO)">
            <SelectParameters>
                <asp:SessionParameter Name="ASENO" SessionField="aseno" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>"
            SelectCommand="select ASENO,QDATE,PARTICULAR,FORMAT(OTHERCHARGES,'n2') as OTHERCHARGES,format(NETPRICE,'n2') as NETPRICE,format(ACTUALPRICE,'n2') as ACTUALPRICE,format(MOBILIZATION,'n2') AS MOBILIZATION,FOC, TELNO,PREPAREDBY,APPROVEDBY,ACCEPTEDBY from quotationtb as a
LEFT JOIN CALLINTB AS B ON A.CIN = B.CIN WHERE ([ASENO] = @ASENO)">
            <SelectParameters>
                <asp:SessionParameter Name="ASENO" SessionField="aseno" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>"
            SelectCommand="select * from notetb"></asp:SqlDataSource>

        <rsweb:ReportViewer ID="ReportViewer1" Height="800" Width="100%" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
            <LocalReport ReportPath="AFTERSALESPROJ\report\RPTquotationclient.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                    <rsweb:ReportDataSource DataSourceId="SqlDataSource2" Name="DataSet2" />
                    <rsweb:ReportDataSource DataSourceId="SqlDataSource3" Name="DataSet3" />
                </DataSources>
            </LocalReport>

        </rsweb:ReportViewer>
    </form>
</body>
</html>
