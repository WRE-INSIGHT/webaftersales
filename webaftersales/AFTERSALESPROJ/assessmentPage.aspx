<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="assessmentPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.assessmentPage" %>

<asp:Content ID ="Content1" ContentPlaceHolderID="head" runat="server" >
    <title>Assessment</title>
</asp:Content>

<asp:Content ID ="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server" >
    <div class="container">
        <div class="page-header">
            <h1>Assessment</h1>
        </div>
    </div>
    <div class="container">
        <asp:Label ID="lblkno" runat="server" Text="Label"></asp:Label><br/>
        <asp:Button ID="btnreload" runat="server" Text="refresh" CssClass="btn btn-default" OnClick="btnreload_Click" />
        <asp:GridView AlternatingRowStyle-CssClass="table" ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="STOCKNO" EmptyDataText="No result found">
            <Columns>
                <asp:BoundField HeaderText="STOCKNO" DataField="STOCKNO" />
                     <asp:BoundField HeaderText="HEADER" DataField="HEADER" />
                     <asp:BoundField HeaderText="COSTHEAD" DataField="COSTHEAD" />
                     <asp:BoundField HeaderText="TYPECOLOR" DataField="TYPECOLOR" />
                     <asp:BoundField HeaderText="ARTICLE" DataField="ARTICLE" />
                     <asp:BoundField HeaderText="DESCRIPTION" DataField="DESCRIPTION" />
            </Columns>
        </asp:GridView>
    </div>
   
</asp:Content>