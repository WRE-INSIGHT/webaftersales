<%@ Page Title="" Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="FRMservicingschedule.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/CSSservicing.css" rel="stylesheet" />
    <link href="css/CSSreporting.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Label ID="lblsearch" runat="server" Text="find"></asp:Label>
    <asp:TextBox ID="tboxsearchkey" CssClass="tboxinput" runat="server"></asp:TextBox>
    <asp:Button ID="btnsearch" CssClass="myButton" runat="server" Text="search" OnClick="btnsearch_Click" />
    <br />
    <br />
    <div id="pageerror">
        <asp:Label ID="lblerror" runat="server" Text="" ForeColor="Red"></asp:Label>
    </div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AllowPaging="True"
        OnPageIndexChanging="GridView1_PageIndexChanging" Font-Names="Segoe UI" Font-Size="12px" Font-Strikeout="False"
        OnRowCommand="GridView1_RowCommand"
        OnRowDataBound="GridView1_RowDataBound" DataKeyNames="ID" EmptyDataText="No result found."
        EnablePersistedSelection="True" OnPageIndexChanged="GridView1_PageIndexChanged"
        CellPadding="3" GridLines="Vertical" ShowFooter="True" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" PageSize="5">
        <AlternatingRowStyle BackColor="#DCDCDC" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBoxselect" runat="server" CommandName="selectbtn" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="ID" DataField="ID" />
            <asp:BoundField HeaderText="DATE" DataField="DATE" ItemStyle-Width="100px">
                <ItemStyle Width="100px"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField HeaderText="SERVICING" DataField="SERVICING" ItemStyle-Width="100px">
                <ItemStyle Width="100px"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField HeaderText="JO" DataField="JO" />
            <asp:BoundField HeaderText="PROJECT" DataField="PROJECT" />
            <asp:BoundField HeaderText="ADDRESS" DataField="ADDRESS" />
             <asp:BoundField HeaderText="PROFILE_FINISH" DataField="PROFILE_FINISH" />
            <asp:TemplateField ItemStyle-Width="100px">
                <ItemTemplate>
                    <asp:Button runat="server" Text="report" CommandName="report" CssClass="myButton" />
                </ItemTemplate>
                <ItemStyle Width="100px"></ItemStyle>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
        <PagerSettings PageButtonCount="5" Position="TopAndBottom" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <RowStyle Font-Names="Segoe UI" Font-Size="10pt" Height="50px" BackColor="#EEEEEE" ForeColor="Black" />
        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#0000A9" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#000065" />
    </asp:GridView>
    <asp:Button CssClass="myButton" ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <br />
</asp:Content>
