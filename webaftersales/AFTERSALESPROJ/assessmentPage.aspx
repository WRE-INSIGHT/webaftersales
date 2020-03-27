<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="assessmentPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.assessmentPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Assessment</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="page-header">
            <h1>
                <asp:Label ID="lblkno" runat="server" Text="Label"></asp:Label><small>
                    <asp:Label ID="lbllocation" runat="server" Text="Label"></asp:Label></small></h1>
        </div>
    </div>
    <div class="container">
        <div class="page-header">
            <h3>Cutting List</h3>
            <div class="navbar-right">
                <asp:HyperLink ID="HyperLink1" Width="160" CssClass="btn btn-default" NavigateUrl="~/AFTERSALESPROJ/reportPage.aspx" runat="server" Text="&lt;&lt; back to report"></asp:HyperLink>
            </div>
        </div>

        <br />
    
                <asp:GridView ID="GridView1" CssClass="table" runat="server"
                    AutoGenerateColumns="False" EmptyDataText="No result found."
                    AllowPaging="True" DataKeyNames="ID"
                    OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="5" OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="cboxselect" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="ID" DataField="ID" />
                        <asp:BoundField HeaderText="STOCKNO" DataField="STOCKNO" />
                        <asp:BoundField HeaderText="HEADER" DataField="HEADER" />
                        <asp:BoundField HeaderText="COSTHEAD" DataField="COSTHEAD" />
                        <asp:BoundField HeaderText="TYPECOLOR" DataField="TYPECOLOR" />
                        <asp:BoundField HeaderText="ARTICLENO" DataField="ARTICLENO" />
                        <asp:BoundField HeaderText="DESCRIPTION" DataField="DESCRIPTION" />
                    </Columns>
                </asp:GridView>
                <asp:Button ID="importbtn" CssClass="btn btn-default" runat="server" Text="Import selected items" OnClick="importbtn_Click" />
         
        <div class="page-header">
            <h3>Assessment</h3>
        </div>

     
            <asp:GridView CssClass="table table-hover" ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField HeaderText="ID" DataField="ID" />
                           <asp:BoundField HeaderText="RID" DataField="REPORTID" />
                           <asp:BoundField HeaderText="STOCKNO" DataField="STOCKNO" />
                           <asp:BoundField HeaderText="DESCRIPTION" DataField="DESCRIPTION" />
                           <asp:BoundField HeaderText="ASSESSMENT" DataField="ASSESSMENT" />
                </Columns>
            </asp:GridView>
      
    </div>

</asp:Content>
