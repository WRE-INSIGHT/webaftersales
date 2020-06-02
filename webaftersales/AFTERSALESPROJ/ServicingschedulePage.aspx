<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="ServicingschedulePage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.ServicingschedulePage" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Servicing Records</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="well">
        <h3><strong>Servicing Records</strong><small> as per call-in control#</small></h3>
        <div class="input-group">
            <asp:TextBox ID="servicingkeytbox" CssClass="form-control" runat="server"></asp:TextBox>
            <div class="input-group-btn">
                <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-primary" OnClick="LinkButton2_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            </div>
        </div>
    </div>



    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="val1" runat="server" />
    <asp:GridView ID="GridView1" runat="server" GridLines="None" AutoGenerateColumns="false" OnRowCommand="GridView1_RowCommand"
        AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <div class='<%# Eval("STATUS").ToString() == "Done" ? "panel panel-success" : "panel panel-danger" %>'>
                        <div class="panel-heading">
                            <asp:Label ID="Label4" runat="server" Font-Size="15px" Text='<%# Bind("CIN")  %>'></asp:Label>
                            <asp:Label ID="Label3" CssClass="navbar-right" Font-Size="15px" runat="server" Text='<%# Bind("CDATE") %>'></asp:Label>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-sm-6">
                                    <strong>
                                        <asp:Label ID="Label1" Font-Size="20px" runat="server" Text='<%# Bind("PROJECT")  %>'></asp:Label></strong>
                                    <br />
                                    <asp:Label ID="Label2" Font-Size="15px" runat="server" Text='<%# Bind("FULLADD")  %>'></asp:Label>
                                    <br />
                                </div>
                                <div class="col-sm-6">
                                    <div class="panel">
                                       <asp:GridView ID="GridView2" runat="server" DataSource='<%# Bind("schedule") %>' OnRowCommand="GridView2_RowCommand"
                                            AutoGenerateColumns="False" CssClass="table">
                                            <Columns>
                                                <asp:BoundField HeaderText="Status" DataField="STATUS" />
                                                <asp:BoundField HeaderText="Servicing" DataField="SERVICING" />
                                                <asp:BoundField HeaderText="Date" DataField="SDATE" />
                                                
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label5" runat="server" Visible="false" Text='<%# Eval("ID") %>'></asp:Label>
                                                        <asp:Label ID="Label6" runat="server" Visible="false" Text='<%# Eval("callin") %>'></asp:Label>
                                                        <asp:LinkButton ID="LinkButton1" CommandName="viewreport" Width="70" CssClass="btn btn-default" runat="server">report</asp:LinkButton>
                                                        <asp:LinkButton ID="LinkButton3" CommandName="viewphoto" Width="70" CssClass="btn btn-default" runat="server">photo</asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>     
                                        </asp:GridView>
                                       </div>
                                </div>
                            </div>            
                        </div>
                        <div class="panel-footer">
                            <asp:Label ID="Label8" CssClass="text-muted" runat="server" Text="caller "></asp:Label> <asp:Label ID="Label7" Font-Size="15px" runat="server" Text='<%# Bind("CALLER") %>'></asp:Label>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

        <PagerSettings PageButtonCount="8" />

        <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
        <EmptyDataTemplate>
            <div class="alert alert-danger">
                <h2><strong>Empty Table!</strong>
                    <small>0 result found</small>
                </h2>
            </div>
        </EmptyDataTemplate>
    </asp:GridView>

</asp:Content>
