﻿<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="importPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.importPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Import items</title>
    <script>
        function confimmessage() {
            confirm('import selected items?');
        }
        function alerme() {
            alert("data save successfully");
        }
        //function redirectme()
        //{
        //    window.open("frmReport.aspx");
        //}
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="page-header">
            <h1>
                <asp:Label ID="Label1" runat="server" Text="KMDI System data"></asp:Label></h1>
        </div>


        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <div class="input-group">
                    <asp:DropDownList ID="locationdl" Height="40" CssClass="form-control" runat="server"></asp:DropDownList>
                    <div class="input-group-btn">
                        <asp:Button ID="searchbtn" Height="40" CssClass="btn btn-primary" runat="server" Text="Find" OnClick="searchbtn_Click" />
                    </div>
                </div>
                <br />
                <asp:GridView ID="GridView1" CssClass="table" runat="server" 
                    AutoGenerateColumns="False" EmptyDataText="No result found." 
                    AllowPaging="True" DataKeyNames="ID" 
                     OnPageIndexChanging="GridView1_PageIndexChanging"
                     OnRowDataBound="GridView1_RowDataBound">
                    <Columns>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="cboxselect" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="ID" DataField="ID" />
                        <asp:BoundField HeaderText="K#" DataField="KMDI_NO" />
                        <asp:BoundField HeaderText="ITEM#" DataField="ITEM_NO" />
                        <asp:BoundField HeaderText="LOCATION" DataField="LOCATION" />
                        <asp:BoundField HeaderText="JO" DataField="job_order_no" />
                    </Columns>
                </asp:GridView>
                <div class="container">
                    <div class=" navbar-left">
                        <asp:Button ID="btnimport" Width="160" CssClass="btn btn-success" runat="server" OnClick="btnimport_Click" Text="import selected items" />
                    </div>
                    <div class="navbar-right">
                        <asp:HyperLink ID="HyperLink1" Width="160" CssClass="btn btn-default" NavigateUrl="~/AFTERSALESPROJ/reportPage.aspx" runat="server" Text="&lt;&lt; back to report"></asp:HyperLink>
                    </div>
                </div>
                <br />
                <br />
                <br />
                <div>
                    <asp:Label ID="errorlbl" Visible="false" CssClass="alert alert-danger" runat="server" Text="Label"></asp:Label>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>