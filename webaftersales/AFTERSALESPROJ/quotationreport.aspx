<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="quotationreport.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotationreport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Quotation Report</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>PROPOSED AFTER SALES SERVICE QUOTATION</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton4" CssClass="btn btn-default" runat="server" OnClick="LinkButton4_Click">back</asp:LinkButton>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        SelectCommand="select 
  a.ASENO,a.ITEM,a.KNO,a.WDWLOC,b.UNITPRICE,b.QTY,b.NETAMOUNT,b.MARKUP,b.ARTICLENO,b.DESCRIPTION from ITEMTB as a
  inner join partstb as b on a.id = b.iid WHERE (a.[ASENO] = @ASENO) order by a.ITEM asc">
        <SelectParameters>
            <asp:SessionParameter Name="ASENO" SessionField="aseno" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        SelectCommand="select ASENO,QDATE,PARTICULAR,FORMAT(OTHERCHARGES,'n2') as OTHERCHARGES,format(NETPRICE,'n2') as NETPRICE,format(ACTUALPRICE,'n2') as ACTUALPRICE,MOBILIZATION,TRANSPORTATION,MATERIAL_SURCHARGES,FOC, TELNO,PREPAREDBY,APPROVEDBY,ACCEPTEDBY,FORMAT(VAT_AMOUNT,'n2') as VAT_AMOUNT,LABOR,LABOR_REMARKS from quotationtb as a
LEFT JOIN CALLINTB AS B ON A.CIN = B.CIN WHERE ([ASENO] = @ASENO)">
        <SelectParameters>
            <asp:SessionParameter Name="ASENO" SessionField="aseno" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
        SelectCommand="select * from notetb"></asp:SqlDataSource>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <rsweb:reportviewer id="ReportViewer1" width="100%" height="800" runat="server" font-names="Verdana" font-size="8pt" waitmessagefont-names="Verdana" waitmessagefont-size="14pt">
                <LocalReport ReportPath="AFTERSALESPROJ\report\RPTquotation.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                        <rsweb:ReportDataSource DataSourceId="SqlDataSource2" Name="DataSet2" />
                        <rsweb:ReportDataSource DataSourceId="SqlDataSource3" Name="DataSet3" />
                    </DataSources>
                </LocalReport>
            </rsweb:reportviewer>

            <div class="row">
                <div class="col-sm-4">
                    <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;PREPARED BY</asp:LinkButton>
                </div>
                <div class="col-sm-4">
                    <asp:LinkButton ID="LinkButton2" CssClass="btn btn-default" runat="server" OnClick="LinkButton2_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;APPROVED BY</asp:LinkButton>
                </div>
                <div class="col-sm-4">
                    <asp:LinkButton ID="LinkButton3" Visible="false" CssClass="btn btn-default" runat="server" OnClick="LinkButton3_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;ACCEPTED BY</asp:LinkButton>
                </div>
            </div>
            <br />
            <br />

            <asp:Label ID="Label1" runat="server" CssClass="text-muted" Text="Label">Copy and Paste this link to share.</asp:Label><br />
            <asp:HyperLink ID="HyperLink1" runat="server">HyperLink</asp:HyperLink>
           
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
