#include <gtk-3.0/gtk/gtk.h>

void reboot(GtkWidget *clear, gpointer data){
    system("systemctl reboot -i");
}

//gcc ./reboot.c -o "Reboot" `pkg-config --cflags --libs gtk+-3.0`
int main(int argc, char **argv){
    //int widgets
    GtkWidget *window, *grid, *payload, *label, *para;
    GdkPixbuf *pixbuf;
    gtk_init(&argc, &argv);
    //create window    
    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
        gtk_window_set_default_size(GTK_WINDOW(window), 300, 200);
        gtk_window_set_resizable(GTK_WINDOW(window), FALSE);
        g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);
    //set icon
    pixbuf = gdk_pixbuf_new_from_file("./icons/GPUPM.png", NULL);
        gtk_window_set_icon(GTK_WINDOW(window), pixbuf);
    //set grid for reboot button
    grid = gtk_box_new(TRUE, 1);
        gtk_container_add(GTK_CONTAINER(window), grid);
    //title
    label = gtk_label_new("null");
        gtk_label_set_markup (GTK_LABEL (label), "<span font='17'>Reboot System</span>");//background='black'
        gtk_container_add(GTK_CONTAINER(grid), label);
        gtk_box_pack_start(GTK_BOX(grid), label, 0,1,1);
        gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_CENTER);
    //text
    para = gtk_label_new("null");
        gtk_label_set_markup (GTK_LABEL (para), "<span font='11'>\nYour systems configuration has changed!\nPlease reboot system load new configuration\n\n</span>");
        gtk_container_add(GTK_CONTAINER(grid), para);
        gtk_box_pack_start(GTK_BOX(grid), para, 0,1,1);
        gtk_label_set_justify(GTK_LABEL(para), GTK_JUSTIFY_CENTER);
    //reboot button
    payload = gtk_button_new_with_label("\nReboot\n");
        g_signal_connect(payload, "clicked", G_CALLBACK(reboot), NULL);
        gtk_box_pack_start(GTK_BOX(grid), payload, 0,1,1);
    //show window
    gtk_widget_show_all(window);
    gtk_main();
    return 0;
}
