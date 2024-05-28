<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="quotationreportclient.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotationreportclient" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

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
        <div class="container">
            <div class="well">
                <h3><strong>PROPOSED AFTER SALES SERVICE QUOTATION</strong></h3>
            </div>
            <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                SelectCommand="select 
  a.ASENO,a.ITEM,a.KNO,a.WDWLOC,b.UNITPRICE,b.QTY,b.NETAMOUNT,b.MARKUP,b.ARTICLENO,b.DESCRIPTION from ITEMTB as a
  inner join partstb as b on a.id = b.iid WHERE (a.[ASENO] = @ASENO)">
                <SelectParameters>
                    <asp:SessionParameter Name="ASENO" SessionField="aseno" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                SelectCommand="select ASENO,QDATE,PARTICULAR,FORMAT(OTHERCHARGES,'n2') as OTHERCHARGES,format(NETPRICE,'n2') as NETPRICE,format(ACTUALPRICE,'n2') as ACTUALPRICE,format(MOBILIZATION,'n2') AS MOBILIZATION,FOC, TELNO,PREPAREDBY,APPROVEDBY,ACCEPTEDBY from quotationtb as a
LEFT JOIN CALLINTB AS B ON A.CIN = B.CIN WHERE ([ASENO] = @ASENO)">
                <SelectParameters>
                    <asp:SessionParameter Name="ASENO" SessionField="aseno" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server"
                SelectCommand="select * from notetb"></asp:SqlDataSource>

            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" PostBackUrl="~/AFTERSALESPROJ/quotationreportclientsignature.aspx" runat="server">Please Sign here</asp:LinkButton>
            <div style="overflow-x: auto">
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" SizeToReportContent="true">
                    <LocalReport ReportPath="AFTERSALESPROJ\report\RPTquotationclient.rdlc">
                        <DataSources>
                            <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                            <rsweb:ReportDataSource DataSourceId="SqlDataSource2" Name="DataSet2" />
                            <rsweb:ReportDataSource DataSourceId="SqlDataSource3" Name="DataSet3" />
                        </DataSources>
                    </LocalReport>
                </rsweb:ReportViewer>
            </div>
            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-primary" PostBackUrl="~/AFTERSALESPROJ/quotationreportclientsignature.aspx" runat="server">Please Sign here</asp:LinkButton>
        </div>
    </form>
</body>
</html>
