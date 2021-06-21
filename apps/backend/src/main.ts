import { NestFactory } from '@nestjs/core';
import { DemoModule } from './demo.module';

async function bootstrap() {
  const app = await NestFactory.create(DemoModule);
  await app.listen(process.env.PORT ? process.env.PORT : 3000);
}
bootstrap();
