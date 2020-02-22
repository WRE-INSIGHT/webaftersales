<%@ Page Title="" Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="FRMservicingschedule.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/CSSservicing.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Label ID="lblsearch" runat="server" Text="find"></asp:Label>
    <asp:TextBox ID="tboxsearchkey" runat="server"></asp:TextBox>
    <asp:Button ID="btnsearch" runat="server" Text="search" OnClick="btnsearch_Click" />
    <br />
    <br />
    <div id="pageerror">
        <asp:Label ID="lblerror" runat="server" Text="" ForeColor="Red"></asp:Label>
    </div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AllowPaging="True"
        OnPageIndexChanging="GridView1_PageIndexChanging" Font-Names="Segoe UI" Font-Size="12px" Font-Strikeout="False"
        OnRowCommand="GridView1_RowCommand"
        OnRowDataBound="GridView1_RowDataBound" DataKeyNames="ID" EmptyDataText="No result found." EnablePersistedSelection="True" OnPageIndexChanged="GridView1_PageIndexChanged" CellPadding="4" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
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
            <asp:BoundField HeaderText="PROJECT" DataField="PROJECT" />
            <asp:BoundField HeaderText="ADDRESS" DataField="ADDRESS" />

            <asp:TemplateField ItemStyle-Width="100px">
                <ItemTemplate>
                    <asp:Button runat="server" Text="report" CommandName="report" CssClass="myButton"/>            
                </ItemTemplate>
                <ItemStyle Width="100px"></ItemStyle>
            </asp:TemplateField>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerSettings PageButtonCount="5" Position="TopAndBottom" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle Font-Names="Segoe UI" Font-Size="10pt" Height="50px" BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:Button CssClass="myButton" ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <br />
</asp:Content>
