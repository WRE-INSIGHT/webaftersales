<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="quotationreport.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotationreport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quotation Report</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Quotation Report</strong></h3>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>"
        SelectCommand="select 
  a.ASENO,a.ITEM,a.KNO,a.WDWLOC,b.UNITPRICE,b.qty,b.NETAMOUNT,b.MARKUP,b.ARTICLENO,b.DESCRIPTION from ITEMTB as a
  inner join partstb as b on a.id = b.iid WHERE (a.[ASENO] = @ASENO)">
        <SelectParameters>
            <asp:SessionParameter Name="ASENO" SessionField="aseno" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server"  ConnectionString="<%$ ConnectionStrings:sqlcon %>"
        SelectCommand="select ASENO,QDATE,PARTICULAR,FORMAT(OTHERCHARGES,'n2') as OTHERCHARGES,format(NETPRICE,'n2') as NETPRICE,format(ACTUALPRICE,'n2') as ACTUALPRICE,TELNO from quotationtb as a
LEFT JOIN CALLINTB AS B ON A.CIN = B.CIN WHERE ([ASENO] = @ASENO)">
         <SelectParameters>
            <asp:SessionParameter Name="ASENO" SessionField="aseno" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server"   ConnectionString="<%$ ConnectionStrings:sqlcon %>"
       SelectCommand="select * from notetb" >
    </asp:SqlDataSource>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
                <LocalReport ReportPath="AFTERSALESPROJ\report\RPTquotation.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                        <rsweb:ReportDataSource DataSourceId="SqlDataSource2" Name="DataSet2" />
                        <rsweb:ReportDataSource DataSourceId="SqlDataSource3" Name="DataSet3" />
                    </DataSources>
                </LocalReport>
            </rsweb:ReportViewer>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
