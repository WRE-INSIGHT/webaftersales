<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="RefoilingCuttingList.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.RefoilingCuttingList" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Re-foiling Report</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Foiling cutting list</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/refoilingitem.aspx">back</asp:LinkButton>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="select [Id],[Refoiling_Id],[Item_No],[K_No],[Location],[Parts],[Article_No],[Profile_Length],[Profile_Width_In],[Profile_Width_Out],[Qty],[Total_Length],[Total_Area],[Sub_Total],[Average_Price],[Cleaning],[Item_Description] from [Refoiling_Tbl] WHERE [For_Cutting] = 1 and ([Refoiling_Id] = @REFOILING_ID)">
        <SelectParameters>
            <asp:SessionParameter Name="REFOILING_ID" SessionField="refoilingqno" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="800px" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
        <LocalReport ReportPath="AFTERSALESPROJ\report\refoilingCuttingListRPT.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
        <asp:LinkButton ID="LinkButton3" CssClass="btn btn-success" Width="200" runat="server" OnClick="LinkButton3_Click">PREPARED BY</asp:LinkButton>
</asp:Content>