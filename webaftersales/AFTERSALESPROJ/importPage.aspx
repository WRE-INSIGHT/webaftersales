<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="importPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.importPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Import items</title>
    <script>
        function confimmessage() {
            confirm('import selected items?');
        }
        function alerme() {
            alert("data saved successfully");
        }
        //function redirectme()
        //{
        //    window.open("frmReport.aspx");
        //}
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
        <div class="well">
            <h3><strong>
                <asp:Label ID="Label1" runat="server" Text="KMDI System data"></asp:Label></strong></h3>
            <div class="navbar-right">
                <asp:HyperLink ID="HyperLink1" CssClass="btn btn-default" NavigateUrl="~/AFTERSALESPROJ/reportPage.aspx" runat="server" Text="back"></asp:HyperLink>
            </div>
        </div>

        <br />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Sytem data
                    </div>
                    <div class="panel-body">
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
                                <asp:TemplateField HeaderText="ID">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" Visible="true" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="K#" DataField="KMDI_NO" />
                                <asp:BoundField HeaderText="ITEM#" DataField="ITEM_NO" />
                                <asp:BoundField HeaderText="LOCATION" DataField="LOCATION" />
                                <asp:BoundField HeaderText="JO" DataField="job_order_no" />
                            </Columns>
                            <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                            <EmptyDataTemplate>
                                <div class="alert alert-danger">
                                    <h2><strong>Sorry, no data available!</strong>
                                        <small>0 result found</small>
                                    </h2>
                                </div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                    <div class="panel-footer">
                    </div>
                </div>
                <div class=" navbar-left">
                    <asp:Button ID="btnimport" CssClass="btn btn-primary" runat="server" OnClick="btnimport_Click" Text="import" />
                </div>
               
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="val1" runat="server" />

            
            </ContentTemplate>
        </asp:UpdatePanel>
  
</asp:Content>
