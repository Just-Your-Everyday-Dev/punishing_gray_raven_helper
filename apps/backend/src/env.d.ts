declare namespace  NodeJS {
    interface  ProcessEnv {
        PORT : string;
        IMAGE_KIT_PUBLIC_KEY: string;
        IMAGE_KIT_PRIVATE_KEY: string;
        IMAGE_KIT_URL_ENDPOINT: string;
        MONGO_URI: string;
    }
}