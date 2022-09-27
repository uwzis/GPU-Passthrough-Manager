#include <stdio.h>
#include <stdlib.h>
#include <gtk-3.0/gtk/gtk.h>
#include <unistd.h>
#include <stdbool.h>

// Load VFIO driver
void vfiod(GtkWidget *vfio, gpointer data) {
    system("sudo sh ./Scripts/vfio.sh"); // Run VFIO driver script
    system("systemctl reboot");
}

// Load default drivers
void do_calculate(GtkWidget *calculate, gpointer data) {
    system("sudo sh ./Scripts/Default.sh"); // Run default GPU driver script
    system("systemctl reboot"); 
}

// Run first time set up scripts
void first(GtkWidget *payload, gpointer data){
    system("sudo sh ./Scripts/first.sh"); // Run first time setup script
    system("touch ./Scripts/Devices.txt"); // Create IDs.txt file 
    system("systemctl reboot");
}

// Main GitHub page
void reload(GtkWidget *clear, gpointer data){
    system("xdg-open https://github.com/uwzis/GPU-Passthrough-Manager");
}

// Load CSS for GTK
static void load_css ( void ){
    GtkCssProvider *provider;
    GdkDisplay *display;
    GdkScreen *screen;

    const gchar *css_style_file = "./style.css";
    GFile *css_fp               = g_file_new_for_path ( css_style_file );
    GError *error               = 0;

    provider = gtk_css_provider_new ();
    display = gdk_display_get_default ();
    screen  = gdk_display_get_default_screen ( display );

    gtk_style_context_add_provider_for_screen (screen, GTK_STYLE_PROVIDER ( provider ), GTK_STYLE_PROVIDER_PRIORITY_APPLICATION);
    gtk_css_provider_load_from_file ( provider, css_fp, &error);

    g_object_unref ( provider );
}

// toggle button functions,
static void check_state(GtkWidget* widget, gpointer data)
{
    if(gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(widget)))
    {
        //write to file
        g_print("toggled\n");
        system("python3 ./Tools/confmgr.py ./Scripts/vfio.conf add \"10de:2304\"");

    }else
    {   
        //delete from file
        g_print("Toggle button not activated\n");
        system("python3 ./Tools/confmgr.py ./Scripts/vfio.conf remove \"10de:2304\"");

    }
}
//python3 ./Tools/confmgr.py ./Scripts/vfio.conf add "10de:2304"
// gcc ./GPUPassthroughManager.c -o "GPU Passthrough Manager" `pkg-config --cflags --libs gtk+-3.0`
int main(int argc, char **argv){
 
    //if IDs.txt doesnt exist, then start first time setup window, else, run program as normal
    int checkIfFileExists(const char *filename);
    if( access("./Scripts/Devices.txt", F_OK ) != -1){
        system("rm vfio.conf");
        system("echo \"options vfio-pci ids=\" | tee -n ./Scripts/vfio.conf");
        system("rm ./Scripts/Devices.txt | rm ./Tools/IDs.txt"); // Delete existing IDs.txt
        system("sh ./Scripts/scanID.sh"); // Run ID scanning script
        system("python3 ./Tools/pciparse.py ./Scripts/Devices.txt id | tee ./Tools/IDs.txt");
        system("python3 ./Tools/pciparse.py ./Scripts/Devices.txt name | tee ./Tools/Names.txt");
        GtkWidget *window, *grid, *calculate, *vfio, *space, *gpu, *vbox, *toggle, *toggle2, *grid2, *label, *header, *clear;
        gtk_init(&argc, &argv);
        load_css();
//---------------------------------------------------------------------------------------------------------------------------options vfio-pci ids=10de:2208,10de:1aef

//---------------------------------------------------------------------------------------------------------------------------
        window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
            gtk_window_set_resizable(GTK_WINDOW(window), FALSE);
            g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);

        vbox = gtk_box_new(TRUE, 1);
            gtk_container_add(GTK_CONTAINER(window), vbox);

      // Scan and print
        label = gtk_label_new("Welcome to GPU Passthrough Manager\n");
          gtk_container_add(GTK_CONTAINER(vbox), label);
           gtk_box_pack_start(GTK_BOX(vbox), label, 0,1,1);
            gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_CENTER);
      
//if there is an ID, then print the name of the device
        toggle = gtk_toggle_button_new_with_mnemonic("NVIDIA Corporation GA102 3080TI [10de:1aef]");
            gtk_box_pack_start(GTK_BOX(vbox), toggle, 0,1,1);

            g_signal_connect(toggle, "toggled", G_CALLBACK(check_state), NULL);

        toggle2 = gtk_toggle_button_new_with_mnemonic("Intel Corporation CoffeeLake-H GT2 [UHD Graphics 630]");
            gtk_box_pack_start(GTK_BOX(vbox), toggle2, 0,1,1);
            
            g_signal_connect(toggle2, "toggled", G_CALLBACK(check_state), NULL);
            
//end

        grid = gtk_fixed_new();
            
            gtk_container_add(GTK_CONTAINER(vbox), grid);
            
        // Main window (for returning users)
        calculate = gtk_button_new_with_label("Load Default");
            g_signal_connect(calculate, "clicked", G_CALLBACK(do_calculate), NULL);
           
            gtk_fixed_put(GTK_FIXED(grid), calculate, 0, 200);
            gtk_widget_set_size_request(calculate, 200, 30);

        clear = gtk_button_new_with_label("Manual");
            g_signal_connect(clear, "clicked", G_CALLBACK(reload), NULL);
            gtk_fixed_put(GTK_FIXED(grid), clear, 200, 200);
            gtk_widget_set_size_request(clear, 150, 30);

        vfio = gtk_button_new_with_label("  Load VFIO  ");
            g_signal_connect(vfio, "clicked", G_CALLBACK(vfiod), NULL);
            gtk_fixed_put(GTK_FIXED(grid), vfio, 350, 200);
            gtk_widget_set_size_request(vfio, 200, 30);
       
        gtk_widget_show_all(window);
        gtk_main();
    
        return 0;
    }
  
    // First time setup window
    else {
        GtkWidget *window, *grid, *payload, *label;
        gtk_init(&argc, &argv);

        load_css();
    
        window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
        gtk_window_set_default_size(GTK_WINDOW(window), 300, 10);
        
        g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);

        grid = gtk_box_new(TRUE, 1);
            gtk_container_add(GTK_CONTAINER(window), grid);

        label = gtk_label_new("Welcome to GPU Passthrough Manager,\nThis program is for passing through grahics\nand audio devices to virtual machines.\nPress start to add VFIO to modules and\nIOMMU to your machine to get started.");
        gtk_container_add(GTK_CONTAINER(grid), label);
        gtk_box_pack_start(GTK_BOX(grid), label, 0,1,1);
        gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_CENTER);

        payload = gtk_button_new_with_label("Start");
        g_signal_connect(payload, "clicked", G_CALLBACK(first), NULL);
        gtk_box_pack_start(GTK_BOX(grid), payload, 0,1,1);
   
        gtk_widget_show_all(window);
        gtk_main();

        return 0;
    }
}
