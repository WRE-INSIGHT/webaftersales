<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="joborderapproval.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.joborderapproval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Job Order Approval</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>JO Approval</strong></h3>
        <div class="input-group">
            <asp:TextBox ID="searchkey" CssClass="form-control" runat="server"></asp:TextBox>
            <div class="input-group-btn">
                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-default"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            </div>
        </div>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>


            <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
            <asp:GridView ID="GridView1" runat="server" GridLines="None" AllowPaging="True" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <div class='<%# Eval("RSTATUS").ToString() == "" ? "panel panel-default" : Eval("RSTATUS").ToString() == "Approved" ? "panel panel-success" : "panel panel-danger" %>'>
                                <div class="panel-heading">
                                    <asp:Label ID="lblid" runat="server" Visible="false" Text='<%# Bind("ID") %>'></asp:Label>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CIN") %>'></asp:Label>
                                </div>
                                <div class="panel-body">
                                    <strong>
                                        <asp:Label ID="Label3" runat="server" Font-Size="X-Large" Text='<%# Bind("PROJECT") %>'></asp:Label>
                                    </strong>
                                    <br />
                                    <asp:Label ID="addresslbl" Font-Size="15px" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label>
                                    <br />
                                    <asp:Label ID="lbljo" CssClass="text-muted" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                                    <br />
                                    <asp:Label ID="datelbl" Font-Size="XX-Large" runat="server" Text='<%# Bind("requested") %>'></asp:Label><br />


                                    <asp:Panel ID="Panel2" runat="server" Visible='<%# Eval("RSTATUS").ToString() == "" ? true : false  %>'>
                                        <asp:LinkButton Width="100" ID="btnapprove" CommandName="approve" CssClass="btn btn-success" runat="server">Approve</asp:LinkButton>
                                        <asp:LinkButton Width="100" ID="btndisapprove" CommandName="disapprove" CssClass="btn btn-danger" runat="server">Disapprove</asp:LinkButton>
                                    </asp:Panel>

                                    <br />
                                    <asp:Panel ID="Panel1" Visible="false" runat="server">
                                        Message/Comment:
                               <asp:TextBox ID="tboxmessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox><br />

                                        <asp:LinkButton ID="btnsave" CommandName="mysave" CssClass="btn btn-primary" runat="server">save</asp:LinkButton>
                                        <asp:LinkButton ID="btncancel" CommandName="mycancel" CssClass="btn btn-default" runat="server">cancel</asp:LinkButton>
                                    </asp:Panel>

                                    <asp:Panel ID="Panel3" runat="server" Visible='<%# Eval("RSTATUS").ToString() == "" ? false : true  %>'>
                                        <asp:Label ID="Label4" Font-Size="X-Large" runat="server" CssClass='<%# Eval("RSTATUS").ToString() == "Approved" ? "text-success" : "text-danger" %>'
                                            Text='<%# Bind("[RSTATUS]") %>'></asp:Label>&nbsp
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("RSTATUS").ToString()=="Approved" ? Eval("APPROVED").ToString() : Eval("DISAPPROVED").ToString() %>'></asp:Label>
                                        <asp:LinkButton ID="LinkButton2" CommandName="myedit" runat="server">Edit</asp:LinkButton>
                                        <br />
                                        <blockquote>
                                            <asp:Label ID="Label2" CssClass="text-muted" runat="server" Text='<%# Bind("MESSAGE") %>'></asp:Label>
                                        </blockquote>
                                    </asp:Panel>

                                    <asp:Panel ID="Panel4" Visible="false" runat="server">
                                        Message/Comment:
                               <asp:TextBox ID="edittboxmessage" runat="server" Text='<%# Bind("MESSAGE") %>' CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox><br />
                                        <asp:LinkButton Width="100" ID="LinkButton5" CommandName="editapprove" CssClass="btn btn-primary" runat="server">approve</asp:LinkButton>
                                        <asp:LinkButton Width="100" ID="LinkButton3" CommandName="editdisapprove" CssClass="btn btn-danger" runat="server">disapprove</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton4" CommandName="editcancel" CssClass="btn btn-default" runat="server">cancel</asp:LinkButton>
                                    </asp:Panel>
                                </div>
                                <div class="panel-footer">
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="alert alert-danger">
                        <h2><strong>Empty Table!</strong>
                            <small>0 result found</small>
                        </h2>
                    </div>
                </EmptyDataTemplate>
                <PagerSettings PageButtonCount="8" />
                <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
