/* client.hpp: FTP client class definition. */

#pragma once

#include "common.hpp"
#include "server.hpp"
#include "command.hpp"

namespace FTP
{
	class Client
	{
		friend class FTP::Server;

		private:
			std::map<std::string, void*> cvar;

			data_callback cb_data;

			int socket_control;
			int socket_data;
			int socket_pasv;

			Client(int client_socket, FTP::Server* ext_server);

			void socket_disconnect(int socket_dc);
			void socket_event(int socket_ev);

		public:
			FTP::Server* server;
			std::string last_cmd;

			char* buffer_control;
			char* buffer_data;

			void send_message(std::string message);
			void send_code(int code, std::string message);
			void send_multicode(int code, std::string message);
			void send_multimessage(std::string message);

			bool data_start(data_callback callback, short pevents);
			void data_end(void);
			bool pasv_enter(struct sockaddr_in* pasv_addr);

			void* get_cvar(std::string name);
			void set_cvar(std::string name, void* value_ptr);

			int get_control_socket(void);
			int get_data_socket(void);

			~Client(void);
	};
};