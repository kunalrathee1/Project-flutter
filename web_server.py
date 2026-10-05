import http.server
import socketserver
import os
import sys

PORT = 8088
DIRECTORY = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'build', 'web')

class SPAServer(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    def do_GET(self):
        # Clean query string / hash
        clean_path = self.path.split('?')[0].split('#')[0]
        fs_path = self.translate_path(clean_path)
        
        # If requested file does not exist, rewrite to index.html for SPA routing
        if not os.path.exists(fs_path):
            self.path = '/index.html'
        elif os.path.isdir(fs_path):
            index_path = os.path.join(fs_path, 'index.html')
            if not os.path.exists(index_path):
                self.path = '/index.html'

        return super().do_GET()

    def end_headers(self):
        # Enable CORS and disable aggressive caching for local testing
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
        super().end_headers()

if __name__ == '__main__':
    socketserver.TCPServer.allow_reuse_address = True
    print(f"Serving Reliance Smart Bazaar Web from {DIRECTORY} on http://localhost:{PORT}")
    sys.stdout.flush()
    with socketserver.TCPServer(("", PORT), SPAServer) as httpd:
        httpd.serve_forever()
