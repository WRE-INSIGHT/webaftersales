<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/DAILYHEALTHPROFILE/DHPmaster.Master" CodeBehind="dhphome.aspx.cs" Inherits="webaftersales.DAILYHEALTHPROFILE.dhphome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Daily Health Profile</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>My Daily Health Profile</strong>   <small>
            <asp:LinkButton ID="LinkButton1"  runat="server" OnClick="LinkButton1_Click">new</asp:LinkButton></small></h3>


    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />

    <asp:GridView ID="GridView1" AutoGenerateColumns="false" GridLines="None" runat="server" OnRowCommand="GridView1_RowCommand">
   <Columns>
       <asp:TemplateField>
           <ItemTemplate>
                <asp:Label ID="lblid" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
               <asp:Label ID="Label1" CssClass="text-center" Font-Size="X-Large" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>
               <asp:LinkButton ID="LinkButton2" CommandName="answersheet" runat="server">answer sheet</asp:LinkButton>
           </ItemTemplate>
       </asp:TemplateField>
   </Columns>
       
    </asp:GridView>
</asp:Content>
