<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="assessmentmade.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.assessmentmade" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Assessment</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Assessment</strong></h3>
        <div class="navbar-right">
            <asp:HyperLink ID="HyperLink1" CssClass="btn btn-default" NavigateUrl="~/AFTERSALESPROJ/reportPage.aspx" runat="server" Text="back"></asp:HyperLink>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-warning" PostBackUrl="~/AFTERSALESPROJ/assessmentPage.aspx" OnClick="LinkButton3_Click">Import from cutting list</asp:LinkButton><br />
    <h4>
        <asp:Label ID="lblkno" runat="server" Text="Label"></asp:Label>&nbsp;\
    <asp:Label ID="lbllocation" runat="server" Text="Label"></asp:Label>
    </h4>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" AllowPaging="True" runat="server" PageSize="5" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Both" OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="editbtn" CommandName="myedit" runat="server">Edit</asp:LinkButton>
                                <asp:LinkButton ID="deletebtn" CommandName="mydelete" OnClientClick="return confirm('delete this record?')" runat="server">Delete</asp:LinkButton>
                                <asp:LinkButton ID="savebtn" Visible="false" CommandName="mysave" runat="server">Update</asp:LinkButton>
                                <asp:LinkButton ID="cancelbtn" Visible="false" CommandName="mycancel" runat="server">Cancel</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                <asp:Label ID="idlbl" runat="server" Visible="false" Text='<%# Bind("ID") %>'></asp:Label>
                                <asp:Label ID="Label2" runat="server" Visible="false" Text='<%# Bind("REPORTID") %>'></asp:Label>
                                <asp:Label ID="descriptionlbl" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                                <asp:TextBox ID="descriptiontbox" TextMode="MultiLine" Rows="10" Width="400" Visible="false" Text='<%# Eval("DESCRIPTION") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Assessment" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <div style="white-space:normal; word-wrap: normal; min-width:300px;">
                                    <asp:Label ID="assessmentlbl" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("ASSESSMENT").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                                </div>

                                <asp:TextBox ID="assessmenttbox" Visible="false" TextMode="MultiLine" Width="400" Rows="10" Text='<%# Eval("ASSESSMENT") %>' CssClass="form-control" runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Progress" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:Label ID="progresslbl" runat="server" Text='<%# Bind("PROGRESS") %>'></asp:Label>
                                <asp:DropDownList ID="progressddl" Visible="false" runat="server" Text='<%# Eval("PROGRESS") %>' CssClass="form-control">
                                    <asp:ListItem>-</asp:ListItem>
                                    <asp:ListItem>in progress</asp:ListItem>
                                    <asp:ListItem>finished</asp:ListItem>
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DATE MODIFIED">
                            <ItemTemplate>
                                <div style="white-space: normal; text-wrap: normal"></div>
                                <asp:Label ID="lblDate_Modified" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("DATE_MODIFIED").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                    <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                    <PagerSettings PageButtonCount="8" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Right" ForeColor="Black" BackColor="White" />
                    <EmptyDataTemplate>
                        <div class="">
                            <h2><strong>This Table is empty</strong>
                                <small>no assessment made!</small>
                            </h2>
                        </div>
                    </EmptyDataTemplate>
                    <RowStyle Wrap="False" />


                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                    <SortedDescendingHeaderStyle BackColor="#242121" />
                </asp:GridView>
            </asp:Panel>

        </ContentTemplate>
    </asp:UpdatePanel>

    <div class="well">
        <h3>New record</h3>
        Description<br />
        <asp:TextBox ID="newdescriptiontbox" CssClass="form-control" runat="server"></asp:TextBox><br />
        Assessment<br />
        <asp:TextBox ID="newassessmenttbox" TextMode="MultiLine" Rows="10" CssClass="form-control" runat="server"></asp:TextBox><br />
        Progress<br />
        <asp:DropDownList ID="newprogressddl" runat="server" CssClass="form-control">
            <asp:ListItem>-</asp:ListItem>
            <asp:ListItem>in progress</asp:ListItem>
            <asp:ListItem>finished</asp:ListItem>
        </asp:DropDownList><br />
        <asp:Button ID="newbtn" CssClass="btn btn-primary" runat="server" Text="add" OnClick="newbtn_Click" />
    </div>
</asp:Content>
