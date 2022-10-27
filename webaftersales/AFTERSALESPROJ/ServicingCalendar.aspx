<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="ServicingCalendar.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.ServicingCalendar" %>



<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Servicing Calendar</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well">
        <h2>Servicing Calendar
            <asp:Label ID="lblDate" runat="server" CssClass="text-primary" Text=""></asp:Label></h2>
        <div class="row">
            <div class="col-sm-2">
                Status<br />
                <asp:CheckBox ID="CheckBox1" Text="Done Servicing" runat="server" Checked="True" />
            </div>

            <div class="col-sm-3">
                Area
                <asp:DropDownList ID="ddlarea" runat="server" CssClass="form-control">
                    <asp:ListItem>All</asp:ListItem>
                    <asp:ListItem>Luzon</asp:ListItem>
                    <asp:ListItem>Visayas</asp:ListItem>
                    <asp:ListItem>Mindanao</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm-3">
                Month
                <asp:DropDownList CssClass="form-control" ID="ddlmonth" runat="server">
                    <asp:ListItem Text="Jan" Value="01"></asp:ListItem>
                    <asp:ListItem Text="Feb" Value="02"></asp:ListItem>
                    <asp:ListItem Text="Mar" Value="03"></asp:ListItem>
                    <asp:ListItem Text="Apr" Value="04"></asp:ListItem>
                    <asp:ListItem Text="May" Value="05"></asp:ListItem>
                    <asp:ListItem Text="Jun" Value="06"></asp:ListItem>
                    <asp:ListItem Text="Jul" Value="07"></asp:ListItem>
                    <asp:ListItem Text="Aug" Value="08"></asp:ListItem>
                    <asp:ListItem Text="Sep" Value="09"></asp:ListItem>
                    <asp:ListItem Text="Oct" Value="10"></asp:ListItem>
                    <asp:ListItem Text="Nov" Value="11"></asp:ListItem>
                    <asp:ListItem Text="Dec" Value="12"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm-4">
                Year
            <div class="input-group">
                <asp:TextBox ID="tboxyear" runat="server" TextMode="Number" CssClass="form-control">2022</asp:TextBox>
                <div class="input-group-btn">
                    <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click">Submit</asp:LinkButton>
                </div>
            </div>
            </div>
        </div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
      <div class="well">
        <span style="font-size:large">LEGEND</span>
        <div class="row">
            <div class="col-sm-2">
                <div style="padding: 7px; background-color: black;"><span style="color: white; font-size: small">in progress</span> </div>
            </div>
            <div class="col-sm-2">
                <div style="padding: 7px; background-color: green;"><span style="color: white; font-size: small">Done</span> </div>
            </div>
        </div>
    </div>
    <h1 class="text-center">
        <strong>
            <asp:Label ID="lblMonth" CssClass="text-success" runat="server"></asp:Label></strong>
    </h1>
    <asp:Panel runat="server" ID="Panel1" ScrollBars="Auto">
        <asp:GridView ID="GridView1" CssClass="tbl" AutoGenerateColumns="False" runat="server" CellPadding="3" GridLines="Both" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellSpacing="1" OnRowCommand="GridView1_RowCommand">
            <Columns>
                <asp:TemplateField HeaderText="Monday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                    <ItemTemplate>
                        <div style="min-width: 150px;">
                            <asp:LinkButton ID="linkbtnMon" CommandName="viewlistMon" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Content").ToString() == "Date" ? true : false %>' Text='<%# Bind("Monday") %>'></asp:LinkButton>
                            <asp:Label ID="lbl1date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Monday") %>'></asp:Label>
                            <asp:Label ID="lbl1content" Visible='<%# Eval("Content").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Monday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle Width="200px"></HeaderStyle>
                    <ItemStyle Wrap="True"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tuesday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                    <ItemTemplate>
                        <div style="min-width: 150px;">
                            <asp:LinkButton ID="linkbtnTue" CommandName="viewlistTue" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Content").ToString() == "Date" ? true : false %>' Text='<%# Bind("Tuesday") %>'></asp:LinkButton>
                            <asp:Label ID="lbl2date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Tuesday") %>'></asp:Label>
                            <asp:Label ID="lbl2content" Visible='<%# Eval("Content").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Tuesday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                        </div>
                    </ItemTemplate>

                    <HeaderStyle Width="200px"></HeaderStyle>

                    <ItemStyle Wrap="True"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Wednesday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                    <ItemTemplate>
                        <div style="min-width: 150px;">
                            <asp:LinkButton ID="linkbtnWed" CommandName="viewlistWed" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Content").ToString() == "Date" ? true : false %>' Text='<%# Bind("Wednesday") %>'></asp:LinkButton>
                            <asp:Label ID="lbl3date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Wednesday") %>'></asp:Label>
                            <asp:Label ID="lbl3content" Visible='<%# Eval("Content").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Wednesday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                        </div>
                    </ItemTemplate>

                    <HeaderStyle Width="200px"></HeaderStyle>

                    <ItemStyle Wrap="True"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Thursday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                    <ItemTemplate>
                        <div style="min-width: 150px;">
                            <asp:LinkButton ID="linkbtnThu" CommandName="viewlistThu" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Content").ToString() == "Date" ? true : false %>' Text='<%# Bind("Thursday") %>'></asp:LinkButton>
                            <asp:Label ID="lbl4date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Thursday") %>'></asp:Label>
                            <asp:Label ID="lbl4content" Visible='<%# Eval("Content").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Thursday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                        </div>
                    </ItemTemplate>

                    <HeaderStyle Width="200px"></HeaderStyle>

                    <ItemStyle Wrap="True"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Friday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                    <ItemTemplate>
                        <div style="min-width: 150px;">
                            <asp:LinkButton ID="linkbtnFri" CommandName="viewlistFri" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Content").ToString() == "Date" ? true : false %>' Text='<%# Bind("Friday") %>'></asp:LinkButton>
                            <asp:Label ID="lbl5date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Friday") %>'></asp:Label>
                            <asp:Label ID="lbl5content" Visible='<%# Eval("Content").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Friday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                        </div>
                    </ItemTemplate>

                    <HeaderStyle Width="200px"></HeaderStyle>

                    <ItemStyle Wrap="True"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Saturday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                    <ItemTemplate>
                        <div style="min-width: 150px;">
                            <asp:LinkButton ID="linkbtnSat" CommandName="viewlistSat" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Content").ToString() == "Date" ? true : false %>' Text='<%# Bind("Saturday") %>'></asp:LinkButton>
                            <asp:Label ID="lbl6date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Saturday") %>'></asp:Label>
                            <asp:Label ID="lbl6content" Visible='<%# Eval("Content").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Saturday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                        </div>
                    </ItemTemplate>

                    <HeaderStyle Width="200px"></HeaderStyle>

                    <ItemStyle Wrap="True"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Sunday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                    <ItemTemplate>
                        <div style="min-width: 150px;">
                            <asp:LinkButton ID="linkbtnSun" CommandName="viewlistSun" ForeColor="Red" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Content").ToString() == "Date" ? true : false %>' Text='<%# Bind("Sunday") %>'></asp:LinkButton>
                            <asp:Label ID="lbl7date" ForeColor="Red" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Sunday") %>'></asp:Label>
                            <asp:Label ID="lbl7content" Visible='<%# Eval("Content").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Sunday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                        </div>
                    </ItemTemplate>

                    <HeaderStyle Width="200px"></HeaderStyle>

                    <ItemStyle Wrap="True"></ItemStyle>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
            <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
            <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
            <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#594B9C" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#33276A" />
        </asp:GridView>
    </asp:Panel>
</asp:Content>
